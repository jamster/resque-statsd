# Monkey-patch to record queue length since resque doesn't have hooks that give access to the 
# redis stored object, so we can add metadata
# Ideal solution: contribute to the resque project to add hooks for the push and perform action:
# https://github.com/defunkt/resque/issues/464

module Resque
  module EnqueueTime

    def self.included(base) 
      base.class_eval do
        alias_method :push_without_enqueued_at, :push
        extend ClassMethods
      end
    end

    module ClassMethods
      # Wrapper for the original Resque push method, which adds 
      # enqueued_at time
      def push(queue, item)
        begin
          if item.respond_to?(:[]=)
            item[:enqueued_at] = Time.now
          end
        rescue Exception => e
          Rails.logger.error "Error in Resque::EnqueueTime: #{e.message}"
        end
        push_without_enqueued_at queue, item
      end
    end
  end
end


module Resque
  class Job
    alias_method :perform_without_enqueue_time, :perform

    def perform
      begin
        if payload['enqueued_at']
           queue_time = (Time.now - DateTime.parse(payload['enqueued_at'])) * 1000.0
           StatsdHelper.statsd.timing("queues.#{queue}.queue_time", queue_time)
           StatsdHelper.statsd.timing("total.queue_time", queue_time)
         end
      rescue Exception => e
        Rails.logger.error "Error in Resque::EnqueueTime in recording queue_time in statsd: #{e.message}"
      end  
      perform_without_enqueue_time
    end

  end
end

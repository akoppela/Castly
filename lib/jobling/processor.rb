module Jobling
  class Processor
    class << self
      def enqueue(options = {})
        options = options.with_indifferent_access
        raise "Processor can't be blank" if options[:processor].blank? #Processor can't be blank, so its may be ov, but for us, its normally
        Jobling::Job.create(:queue => options.delete(:queue), :encoded_processor => options.to_json)
      end
    end
  end
end 

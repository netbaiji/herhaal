module Herhaal
  class Model
    class << self
      ##
      # The Herhaal::Model.all class method keeps track of all the models
      # that have been instantiated. It returns the @all class variable,
      # which contains an array of all the models
      def all
        @all ||= []
      end

      ##
      # Return the first model matching +trigger+.
      # Raises Errors::MissingTriggerError if no matches are found.
      def find(trigger)
        trigger = trigger.to_s
        all.each do |model|
          return model if model.trigger == trigger
        end
        raise Errors::Model::MissingTriggerError,
            "Could not find trigger '#{trigger}'."
      end

      ##
      # Find and return an Array of all models matching +trigger+
      # Used to match triggers using a wildcard (*)
      def find_matching(trigger)
        regex = /^#{ trigger.to_s.gsub('*', '(.*)') }$/
        all.select {|model| regex =~ model.trigger }
      end
    end
        
    def initialize(trigger, label, &block)
      @trigger = trigger.to_s
      @label   = label.to_s

      procedure_instance_variables.each do |variable|
        instance_variable_set(variable, Array.new)
      end

      instance_eval(&block) if block_given?
      Model.all << self
    end
    
    ##
    # Adds a database to the array of databases
    # to load during the install process
    def database(name, &block)
      @databases << get_class_from_scope(Database, name).new(self, &block)
    end
    
    def get_class_from_scope(scope, name)
      klass = scope
      name.to_s.split('::').each do |chunk|
        klass = klass.const_get(chunk)
      end
      klass
    end
  end
end
module Herhaal
  module SystemPackages
    class Base
      def initialize(model)
        @model = model
        load_defaults!
      end
    end
  end
end
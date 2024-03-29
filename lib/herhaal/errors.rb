module Herhaal
  module ErrorsHelper
    def const_missing(const)
      if const.to_s.end_with?('Error')
        module_eval("class #{const} < Herhaal::Errors::Error; end")
      else
        module_eval("module #{const}; extend Herhaal::ErrorsHelper; end")
      end
      const_get(const)
    end
  end
    
  module Errors
    extend ErrorsHelper
    
    module Model
      class Error < StandardError
        def self.wrap(orig_err, msg = nil)
          new(msg, orig_err)
        end
        
        def initialize(msg = nil, orig_err = nil)
          super(msg)
          set_backtrace(orig_err.backtrace) if @orig_err = orig_err
        end
        
        def to_s
          return @to_s if @to_s
          orig_to_s = super()

          if orig_to_s == self.class.to_s
            msg = orig_err_msg ?
                "#{orig_err_class}: #{orig_err_msg}" : orig_err_class
          else
            msg = format_msg(orig_to_s)
            msg << "\n  Reason: #{orig_err_class}" + (orig_err_msg ?
                "\n  #{orig_err_msg}" : ' (no message given)') if @orig_err
          end

          @to_s = msg ? msg_prefix + msg : class_name
        end

        private

        def msg_prefix
          @msg_prefix ||= class_name + ': '
        end

        def orig_msg
          @orig_msg ||= to_s.sub(msg_prefix, '')
        end

        def class_name
          @class_name ||= self.class.to_s.sub('Herhaal::Errors::', '')
        end

        def orig_err_class
          return unless @orig_err

          @orig_err_class ||= @orig_err.is_a?(Errors::Error) ?
              @orig_err.send(:class_name) : @orig_err.class.to_s
        end

        def orig_err_msg
          return unless @orig_err
          return @orig_err_msg unless @orig_err_msg.nil?

          msg = @orig_err.is_a?(Errors::Error) ?
              @orig_err.send(:orig_msg) : @orig_err.to_s
          @orig_err_msg = (msg == orig_err_class) ?
              false : format_msg(msg)
        end

        def format_msg(msg)
          msg.gsub(/^ */, '  ').strip
        end
      end
      end
    end
  end
end
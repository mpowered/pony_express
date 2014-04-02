module PonyExpress
  class MessagesController < PonyExpressController
    skip_before_filter :verify_authenticity_token

    http_basic_authenticate_with :name => "pony_express", :password => PonyExpress::Config.secret_key

    def create
      if current_handler.new.handle(message_params)
        render :text => 'Handled successfully', :status => 200
      else
        raise RuntimeError, "#{handler_class_name} failed to handle its message"
      end
    end

    private
      def current_handler
        begin
          handler_class_name.constantize
        rescue NameError
          raise NameError, "No handler found for message :#{message}"
        end
      end

      def handler_class_name
        "#{message}_handler".classify
      end

      def message
        params[:message]
      end

      def message_params
        params[:params]
      end
  end
end

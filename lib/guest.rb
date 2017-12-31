require 'omniauth'

module OmniAuth
  module Strategies
    class Guest
      include OmniAuth::Strategy

      option :fields, %i[name uid]
      option :uid_field, :uid

      def request_phase
        form = OmniAuth::Form.new(title: 'Your name please.',
                                  url: callback_path)
        form.input_field 'hidden', 'uid'
        form.text_field 'Name', 'name'
        form.button 'Sign In'
        form.to_response
      end

      uid do
        request.params[options.uid_field.to_s]
      end

      info do
        options.fields.inject({}) do |hash, field|
          hash[field] = request.params[field.to_s]
          hash
        end
      end
    end
  end
end
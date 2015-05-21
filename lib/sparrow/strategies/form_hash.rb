require 'active_support/core_ext/object/blank'
require 'sparrow/transformable'

module Sparrow
  module Strategies
    class FormHash
      REQUEST_FORM_HASH_KEY = 'rack.request.form_hash'
      include Transformable

      attr_reader :env, :type

      def self.handle(env, type)
        self.new(env, type).handle
      end

      def initialize(env, type = :request, params = nil)
        @env    = env
        @params = params
        @type   = type
      end

      def handle
        super
        handle_form_hash
      end

      def params
        @params || env[REQUEST_FORM_HASH_KEY]
      end

      private

      def handle_form_hash
        if params.present?
          transformed_params = transform_params
          @env[REQUEST_FORM_HASH_KEY] = transformed_params
        end
      end
    end
  end
end

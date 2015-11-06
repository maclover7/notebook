module Notebook
  module StorageAdapters
    class Base
      def initialize(attachment, _options = {})
        @attachment = attachment
      end

      def delete
        fail(
          NotImplementedError,
          'Compliant Notebook storage adapters should define the `delete` method'
        )
      end

      def get
        fail(
          NotImplementedError,
          'Compliant Notebook storage adapters should define the `get` method'
        )
      end

      def upload
        fail(
          NotImplementedError,
          'Compliant Notebook storage adapters should define the `upload` method'
        )
      end

      protected

      attr_reader :attachment
    end
  end
end

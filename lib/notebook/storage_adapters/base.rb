module Notebook
  module StorageAdapters
    class Base
      def initialize(attachment, options = {})
        @attachment = attachment
      end

      def delete
        raise(
          NotImplementedError,
          "Compliant Notebook storage adapters should define the `delete` method",
        )
      end

      def get
        raise(
          NotImplementedError,
          "Compliant Notebook storage adapters should define the `get` method",
        )
      end

      def upload
        raise(
          NotImplementedError,
          "Compliant Notebook storage adapters should define the `upload` method",
        )
      end

      protected

      attr_reader :attachment
    end
  end
end

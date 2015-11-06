require 'fileutils'

module Notebook
  module StorageAdapters
    class Filesystem < Base
      def initialize(attachment, options = {})
        super
        public_directory = Pathname.pwd + 'public'
        @storage_directory = options.fetch("storage_directory", public_directory)
      end

      # Should be receiving an IO like object,
      # can be File, StringIO, etc.
      def upload
        FileUtils.copy(attachment.file, @storage_directory).nil?
      end

      def delete
        true
      end
    end
  end
end

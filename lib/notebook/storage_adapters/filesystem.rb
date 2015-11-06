require 'fileutils'

module Notebook
  module StorageAdapters
    class Filesystem < Base
      def initialize(attachment, options = {})
        super
        @storage_directory = options.fetch("storage_directory", Pathname.pwd + 'spec/fixtures/public')
      end

      def delete
        !!FileUtils.remove(url)
      end

      def upload
        # When this command is successful, it returns nil
        FileUtils.copy(attachment.file, @storage_directory).nil?
      end

      def url
        (@storage_directory + File.basename(attachment.file)).to_s
      end
    end
  end
end

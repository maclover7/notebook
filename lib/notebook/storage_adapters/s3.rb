module Notebook
  module StorageAdapters
    class S3 < Base
      def initialize(attachment, options = {})
        super
        @storage_directory = options.fetch('storage_directory', Notebook.public_directory)
      end

      def delete
        fail 'implement'
        # !!FileUtils.remove(url)
      end

      def upload
        fail 'implement'
        # When this command is successful, it returns nil
        # FileUtils.copy(attachment.file, @storage_directory).nil?
      end

      def url
        fail 'implement'
        # (@storage_directory + File.basename(attachment.file)).to_s
      end
    end
  end
end

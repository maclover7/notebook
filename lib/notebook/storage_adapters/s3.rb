require 'aws-sdk'

module Notebook
  # Return the current S3 options
  def self.s3_options
    @s3_options || {}
  end

  # Allow the user to specify S3 options
  def self.s3_options=(s3_options)
    @s3_options = s3_options
  end

  module StorageAdapters
    class S3 < Base
      def initialize(attachment, options = {})
        super
        @storage_directory = options.fetch('storage_directory', Notebook.public_directory)
        #--
        check_valid_credentials
        @s3_options = Notebook.s3_options
        @s3 = Aws::S3::Resource.new(@s3_options)
        credentials = @s3.client.config.credentials
        @access_key_id = credentials.access_key_id
        @bucket_name = bucket
        @bucket = @s3.bucket(@bucket_name)
      end

      private

      def check_valid_credentials
        credentials = Notebook.s3_options
        required_credential_keys = [:access_key_id, :region, :secret_access_key]
        contains_credentials = required_credential_keys.all? { |k| credentials.key?(k) }

        return if contains_credentials
        fail 'Proper credentials are not defined'
      end
    end
  end
end

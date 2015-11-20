require 'aws-sdk'
require 'securerandom'

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
      attr_reader :s3_file_key

      def initialize(attachment, options = {})
        super
        @storage_directory = options.fetch('storage_directory', Notebook.public_directory)
        #--
        check_valid_credentials
        setup_s3
      end

      def upload
        @s3_file_key = "#{SecureRandom.uuid}/#{File.basename(attachment.file)}"
        @file_object = @bucket.object(@s3_file_key)
        @file_object.upload_file(attachment.file.path)
      end

      private

      def check_valid_credentials
        credentials = Notebook.s3_options
        required_credential_keys = [:access_key_id, :bucket, :region, :secret_access_key]
        contains_credentials = required_credential_keys.all? { |k| credentials.key?(k) }

        return if contains_credentials
        fail 'Proper credentials are not defined'
      end

      def setup_s3
        @s3_options = Notebook.s3_options
        @credentials = Aws::Credentials.new(@s3_options[:access_key_id], @s3_options[:secret_access_key])
        @s3 = Aws::S3::Resource.new(credentials: @credentials, region: @s3_options[:region])
        @bucket = @s3.bucket(@s3_options[:bucket])
      end
    end
  end
end

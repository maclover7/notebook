require 'spec_helper'

describe Notebook::StorageAdapters::S3 do
  describe '#intialize' do
    context 'insufficient hash keys' do
      it 'raises error' do
        expect do
          Notebook::StorageAdapters::S3.new(double)
        end.to raise_exception(
          StandardError,
          'Proper credentials are not defined'
        )
      end
    end

    context 'sufficient hash keys' do
      it 'does not raise error' do
        s3_options = { access_key_id: 'hi', bucket: 'hi', region: 'hi', secret_access_key: 'hi' }
        Notebook.s3_options = s3_options

        expect do
          Notebook::StorageAdapters::S3.new(double)
        end.to_not raise_exception(
          StandardError,
          'Proper credentials are not defined'
        )
      end
    end

    describe '#upload' do
      before do
        @s3_options = { access_key_id: ENV['NOTEBOOK_AWS_ACCESS_KEY_ID'],
                        bucket: ENV['NOTEBOOK_AWS_BUCKET'],
                        region: ENV['NOTEBOOK_AWS_REGION'],
                        secret_access_key: ENV['NOTEBOOK_AWS_SECRET_ACCESS_KEY'] }
        Notebook.s3_options = @s3_options
      end

      it 'returns true' do
        file = File.open(SpecHelper.fixture_directory + 'avatar.png')
        attachment = Notebook::Attachment.new(file)
        adapter = Notebook::StorageAdapters::S3.new(attachment)

        result = adapter.upload
        expect(result).to eq(true)
      end

      it 'persists the file' do
        file = File.open(SpecHelper.fixture_directory + 'avatar.png')
        attachment = Notebook::Attachment.new(file)
        adapter = Notebook::StorageAdapters::S3.new(attachment)
        adapter.upload

        @credentials = Aws::Credentials.new(@s3_options[:access_key_id], @s3_options[:secret_access_key])
        @s3 = Aws::S3::Resource.new(credentials: @credentials, region: @s3_options[:region])
        @bucket = @s3.bucket(@s3_options[:bucket])

        result = @bucket.object(adapter.s3_file_key).exists?

        expect(result).to eq(true)
      end
    end
  end

  describe '#s3_options' do
    it 'sets correctly' do
      s3_options = { access_key_id: 'hi', bucket: 'hi', region: 'hi', secret_access_key: 'hi' }
      Notebook.s3_options = s3_options
      expect(Notebook.s3_options).to eq(s3_options)
    end
  end
end

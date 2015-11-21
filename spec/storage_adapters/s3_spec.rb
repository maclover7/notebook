require 'spec_helper'

def setup_s3_client
  @credentials = Aws::Credentials.new(@s3_options[:access_key_id], @s3_options[:secret_access_key])
  @s3 = Aws::S3::Resource.new(credentials: @credentials, region: @s3_options[:region])
  @bucket = @s3.bucket(@s3_options[:bucket])
end

def setup_s3_options
  @s3_options = { access_key_id: ENV['NOTEBOOK_AWS_ACCESS_KEY_ID'],
                  bucket: ENV['NOTEBOOK_AWS_BUCKET'],
                  region: ENV['NOTEBOOK_AWS_REGION'],
                  secret_access_key: ENV['NOTEBOOK_AWS_SECRET_ACCESS_KEY'] }
  Notebook.s3_options = @s3_options
end

def upload_avatar
  @file = File.open(SpecHelper.fixture_directory + 'avatar.png')
  @attachment = Notebook::Attachment.new(@file)
  @adapter = Notebook::StorageAdapters::S3.new(@attachment)
end

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
      before do
        setup_s3_options
      end

      it 'does not raise error' do
        expect do
          Notebook::StorageAdapters::S3.new(double)
        end.to_not raise_exception(
          StandardError,
          'Proper credentials are not defined'
        )
      end
    end

    describe '#delete' do
      before do
        setup_s3_options
        upload_avatar
        @adapter.upload
      end

      it 'returns true' do
        result = @adapter.delete

        expect(result).to_not eq(nil)
      end

      it "deletes the attachment's file" do
        setup_s3_client
        @adapter.delete

        result = @bucket.object(@adapter.s3_file_key).exists?

        expect(result).to eq(false)
      end
    end

    describe '#upload' do
      before do
        setup_s3_options
        upload_avatar
      end

      it 'returns true' do
        result = @adapter.upload
        expect(result).to eq(true)
      end

      it 'persists the file' do
        setup_s3_client
        @adapter.upload

        result = @bucket.object(@adapter.s3_file_key).exists?

        expect(result).to eq(true)
      end
    end

    describe '#url' do
      before do
        setup_s3_options
        upload_avatar
        @adapter.upload
      end

      it 'returns the path to the attachment' do
        result = @adapter.url

        expect(result).to_not eq(nil)
        expect(result).to include('https://moss-notebook-test.s3.amazonaws.com')
        expect(result).to include('avatar.png')
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

require 'spec_helper'

describe Notebook do
  describe 'In general' do
    it 'has a version number' do
      expect(Notebook::VERSION).not_to be nil
    end
  end

  describe '#adapter' do
    after do
      Notebook.adapter = Notebook::StorageAdapters::Filesystem
      Notebook.s3_options = nil
    end

    it 'defaults to Filesystem adapter' do
      expect(Notebook.adapter).to eq(Notebook::StorageAdapters::Filesystem)
    end

    it 'sets correctly' do
      @s3_options = { access_key_id: ENV['NOTEBOOK_AWS_ACCESS_KEY_ID'],
                      bucket: ENV['NOTEBOOK_AWS_BUCKET'],
                      region: ENV['NOTEBOOK_AWS_REGION'],
                      secret_access_key: ENV['NOTEBOOK_AWS_SECRET_ACCESS_KEY'] }
      Notebook.s3_options = @s3_options
      #--
      adapter = Notebook::StorageAdapters::S3
      Notebook.adapter = adapter
      expect(Notebook.adapter).to eq(adapter)
    end
  end

  describe '#public_directory' do
    it 'defaults to public directory' do
      public_directory = Pathname.pwd + 'spec/fixtures/public'
      expect(Notebook.public_directory).to eq(public_directory)
    end

    it 'sets correctly' do
      new_directory = Pathname.pwd + 'spec/fixtures/public'
      Notebook.public_directory = new_directory
      expect(Notebook.public_directory).to eq(new_directory)
    end
  end
end

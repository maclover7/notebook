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
        s3_options = { access_key_id: 'hi', region: 'hi', secret_access_key: 'hi' }
        Notebook.s3_options = s3_options

        expect do
          Notebook::StorageAdapters::S3.new(double)
        end.to_not raise_exception(
          StandardError,
          'Proper credentials are not defined'
        )
      end
    end
  end

  describe '#s3_options' do
    it 'sets correctly' do
      s3_options = { access_key_id: 'hi', region: 'hi', secret_access_key: 'hi' }
      Notebook.s3_options = s3_options
      expect(Notebook.s3_options).to eq(s3_options)
    end
  end
end

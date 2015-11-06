require 'spec_helper'

describe Notebook::Attachment do
  describe '#delete' do
    it "deletes the attachment's file" do
      attachment = Notebook::Attachment.new(double)
      adapter = stubbed_adapter_for(attachment)

      attachment.delete

      expect(adapter).to have_received(:delete)
    end
  end

  describe '#upload' do
    it 'persists the file and returns true' do
      file = File.open(SpecHelper.fixture_directory + 'avatar.png')
      attachment = Notebook::Attachment.new(file)

      result = attachment.upload

      expect(result).to eq(true)
      expect(File.exist?('spec/fixtures/public/avatar.png')).to eq(true)
    end
  end

  describe '#url' do
    it 'returns the path to the attachment' do
      file = File.open(SpecHelper.fixture_directory + 'avatar.png')
      attachment = Notebook::Attachment.new(file)
      attachment.upload

      result = attachment.url

      expect(result).to eq((Pathname.pwd + 'spec/fixtures/public/avatar.png').to_s)
    end
  end

  def stubbed_adapter_for(attachment)
    adapter = double('adapter', delete: nil)
    allow(Notebook::StorageAdapters::Filesystem)
      .to receive(:new)
      .with(attachment)
      .and_return(adapter)
    adapter
  end
end

require "spec_helper"

describe Notebook::StorageAdapters::Filesystem do
  describe "#url" do
    it "returns the path to the attachment" do
      file = File.open(SpecHelper.fixture_directory + "avatar.png")
      attachment = Notebook::Attachment.new(file)
      attachment.upload
      adapter = Notebook::StorageAdapters::Filesystem.new(attachment)

      result = adapter.url

      expect(result).to eq((Pathname.pwd + "spec/fixtures/public/avatar.png").to_s)
    end
  end

  describe "#delete" do
    it "deletes the attachment's file" do
      pending
      attachment = Notebook::Attachment.new(double)
      adapter = Notebook::StorageAdapters::Filesystem.new(attachment)

      result = adapter.delete

      expect(result).to eq(true)
      expect(File.exist?(attachment.url)).to eq(false)
    end
  end
end

require "spec_helper"

describe Notebook::StorageAdapters::Filesystem do
  describe "#delete" do
    it "deletes the attachment's file" do
      file = File.open(SpecHelper.fixture_directory + "avatar.png")
      attachment = Notebook::Attachment.new(file)
      adapter = Notebook::StorageAdapters::Filesystem.new(attachment)
      adapter.upload

      result = adapter.delete

      expect(result).to eq(true)
      expect(File.exist?(attachment.url)).to eq(false)
    end
  end

  describe "#upload" do
    it "persists the file and returns true" do
      file = File.open(SpecHelper.fixture_directory + "avatar.png")
      attachment = Notebook::Attachment.new(file)
      adapter = Notebook::StorageAdapters::Filesystem.new(attachment)

      result = adapter.upload

      expect(result).to eq(true)
      expect(File.exist?("spec/fixtures/public/avatar.png")).to eq(true)
    end
  end

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
end

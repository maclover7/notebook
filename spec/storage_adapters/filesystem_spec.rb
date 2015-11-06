require "spec_helper"

describe Notebook::StorageAdapters::Filesystem do
  describe "#delete" do
    it "deletes the attachment's file" do
      pending
      attachment = Notebook::Attachment.new
      adapter = Notebook::StorageAdapters::Filesystem.new(attachment)

      result = adapter.delete

      expect(result).to eq(true)
      expect(File.exist?(attachment.url)).to eq(false)
    end
  end
end

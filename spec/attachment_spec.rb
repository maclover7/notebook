require "spec_helper"

describe Notebook::Attachment do
  describe "#upload" do
    it "returns true" do
      file_name = "avatar.png"
      file = File.open file_path_for(file_name)
      attachment = Notebook::Attachment.new(file)

      result = attachment.upload

      expect(result).to eq(true)
      expect(File.exist?("public/#{file_name}")).to eq(true)
    end
  end

  def file_path_for(file_name)
    SpecHelper.fixture_directory + file_name
  end
end

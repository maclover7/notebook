require "spec_helper"

describe Notebook::StorageAdapters::Base do
  class NotCompliantAdapter < Notebook::StorageAdapters::Base
  end

  describe "#delete" do
    it "raises not implemented error" do
      storage_adapter = NotCompliantAdapter.new(double)

      expect do
        storage_adapter.delete
      end.to raise_exception(
        NotImplementedError,
        "Compliant Notebook storage adapters should define the `delete` method",
      )
    end
  end

  describe "#get" do
    it "raises not implemented error" do
      storage_adapter = NotCompliantAdapter.new(double)

      expect do
        storage_adapter.get
      end.to raise_exception(
        NotImplementedError,
        "Compliant Notebook storage adapters should define the `get` method",
      )
    end
  end

  describe "#upload" do
    it "raises not implemented error" do
      storage_adapter = NotCompliantAdapter.new(double)

      expect do
        storage_adapter.upload
      end.to raise_exception(
        NotImplementedError,
        "Compliant Notebook storage adapters should define the `upload` method",
      )
    end
  end
end

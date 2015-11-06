module Notebook
  class Attachment
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def upload
      adapter.upload
    end

    private

    def adapter
      StorageAdapters::Filesystem.new(self)
    end
  end
end

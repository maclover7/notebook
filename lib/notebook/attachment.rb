module Notebook
  class Attachment
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def delete
      adapter.delete
    end

    def upload
      adapter.upload
    end

    def url
      adapter.url
    end

    private

    def adapter
      Notebook.adapter.new(self)
    end
  end
end

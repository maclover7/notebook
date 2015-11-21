module Notebook
  module StorageAdapters
    autoload :Base, 'notebook/storage_adapters/base'
    autoload :Filesystem, 'notebook/storage_adapters/filesystem'
    autoload :S3, 'notebook/storage_adapters/s3'
  end
end

module Notebook
  module StorageAdapters
    autoload :Base, "notebook/storage_adapters/base"
    autoload :Filesystem, "notebook/storage_adapters/filesystem"
  end
end

require 'pathname'
require 'notebook/version'

require 'notebook/rails/engine' if defined?(Rails)

module Notebook
  autoload :Attachment, 'notebook/attachment'
  autoload :StorageAdapters, 'notebook/storage_adapters'

  # Return the current storage adapter in use
  def self.adapter
    @adapter || Notebook::StorageAdapters::Filesystem
  end

  # Set the storage adapter constant (ex: Notebook::StorageAdapters::Filesystem) to use
  def self.adapter=(adapter)
    @adapter = adapter
  end

  # Return the current filesystem storage directory in use
  def self.public_directory
    @public_directory || (Pathname.pwd + 'public')
  end

  # Set the storage filesystem directory to use
  def self.public_directory=(directory)
    @public_directory = directory
  end
end

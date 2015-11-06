require 'pathname'
require "notebook/version"

module Notebook
  autoload :Attachment, 'notebook/attachment'
  autoload :StorageAdapters, 'notebook/storage_adapters'

  # Return the current filesystem storage directory in use
  def self.public_directory
    @public_directory || (Pathname.pwd + 'public')
  end

  # Set the  storage filesystem directory to use
  def self.public_directory=(directory)
    @public_directory = directory
  end
end

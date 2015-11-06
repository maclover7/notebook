module Notebook
  class Engine < ::Rails::Engine
    initializer 'notebook.setup' do
      ActiveSupport.on_load :active_record do
        require 'notebook/rails/active_record'
      end
    end
  end
end

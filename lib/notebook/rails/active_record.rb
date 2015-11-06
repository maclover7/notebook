require 'active_record'

module Notebook
  module ActiveRecordAttachment
    extend ActiveSupport::Concern

    module ClassMethods
      # Attachment method which hooks into ActiveRecord models
      def notebook_attachment(name)
        define_method "#{name}" do
          @notebook_attachment
        end

        define_method "#{name}=" do |value|
          @notebook_attachment = Notebook::Attachment.new(value)
          @notebook_attachment.upload
          @notebook_attachment
        end

        after_destroy do
          @notebook_attachment.delete
        end
      end
    end
  end
end

::ActiveRecord::Base.send(:include, Notebook::ActiveRecordAttachment)

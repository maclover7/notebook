require 'spec_helper'
require 'notebook/rails/active_record'

I18n.enforce_available_locales = true

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: File.expand_path('db/db.sqlite', File.dirname(__FILE__)),
  verbosity: 'quiet'
)

ActiveRecord::Schema.define do
  create_table(:posts, force: true) do |t|
    t.timestamps
  end
end

describe Notebook::ActiveRecordAttachment do
  let(:options) { {} }
  let(:klass) do
    # opts = options
    Class.new(ActiveRecord::Base) do
      self.table_name = :posts
      def self.name
        'Post'
      end
      notebook_attachment :document
    end
  end

  describe '#save' do
    it 'stores the assigned file' do
      post = klass.new
      post.document = File.open(SpecHelper.fixture_directory + 'avatar.png')
      post.save
      expect(post.document).to be_an_instance_of(Notebook::Attachment)
    end

    it 'replaces an existing file' do
      post = klass.new
      post.document = File.open(SpecHelper.fixture_directory + 'avatar.png')
      post.save
      old_document = post.document

      post = klass.find(post.id)
      post.document = File.open(SpecHelper.fixture_directory + 'avatar.png')
      post.save

      expect(post.document).to_not eq(old_document)
    end
  end

  describe '#destroy' do
    it 'removes the stored file' do
      post = klass.new
      post.document = File.open(SpecHelper.fixture_directory + 'avatar.png')
      post.save
      post.destroy

      file_name = Notebook.public_directory + 'avatar.png'
      expect(File.exist?(file_name)).to eq(false)
    end
  end
end

require 'spec_helper'

describe Notebook do
  describe 'In general' do
    it 'has a version number' do
      expect(Notebook::VERSION).not_to be nil
    end
  end

  describe '#public_directory' do
    it 'sets correctly' do
      new_directory = Pathname.pwd + 'spec/fixtures/public'
      Notebook.public_directory = new_directory
      expect(Notebook.public_directory).to eq(new_directory)
    end
  end
end

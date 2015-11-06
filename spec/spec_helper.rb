# Load dependencies
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'notebook'
require 'fileutils'
require 'pathname'

ROOT = Pathname.new(File.expand_path('../../', __FILE__))

Dir[ROOT.join("spec/support/**/*.rb")].each { |f| require f }

class SpecHelper
  def self.fixture_directory
    ROOT + 'spec/fixtures'
  end
end

RSpec.configure do |config|
  # Clean up spec/fixtures/public
  config.before :each do
    FileUtils.rm_rf 'spec/fixtures/public'
    FileUtils.mkdir 'spec/fixtures/public'
  end
end

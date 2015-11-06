require "spec_helper"

describe Notebook do
  it "has a version number" do
    expect(Notebook::VERSION).not_to be nil
  end
end

$: << File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')

require "trie"

describe "Trie" do

  before(:each) do
    @trie = Trie.new
  end

  it "should be able to add a new key/value pair" do
    @trie["hello"] = "Dolly"
    @trie["hello"].should == "Dolly"
  end

  it "should return nil if key is not stored" do
    @trie["is not there"].should be_nil
  end
end
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

  describe "#wildcard" do

    before(:each) do
      @trie['hello'] = 'Dolly'
      @trie['hola'] = 'Dolly'
      @trie['adios'] = 'Dolly'
    end

    it "should match without wildcard" do
      @trie.wildcard("hola").should =~ ["hola"]
    end

    it "should match with a wildcard in the middle" do
      @trie.wildcard("h*la").should =~ ["hola"]
    end

    it "should match with several wildcards in a row" do
      @trie.wildcard("h***la").should =~ ["hola"]
    end

    it "should match even with a wildcard at the end" do
      @trie.wildcard("h*l*").should =~ ["hola", "hello"]
    end

    it "should match even with a wildcard at the beginning" do
      @trie.wildcard("*a*").should =~ ["hola", "adios"]
    end
  end

  describe "#longest_prefix" do

    before(:each) do
      @trie["hello"] = "Dolly"
      @trie["hola"] = "adios"
    end

    context "given it contains the key" do
      it "should return the whole" do
        @trie.longest_prefix("hola").should == "hola"
        @trie.longest_prefix("hello").should == "hello"
      end
    end

    context "given it doesn't contain the key" do
      it "should return an empty string if ther is no prefix at all" do
        @trie.longest_prefix("nada").should == ""
      end

      it "should return the longest common prefix" do
        @trie.longest_prefix("holita").should == "hol"
      end
    end
  end
end
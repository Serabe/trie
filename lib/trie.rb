
class Trie
  attr_reader :value, :chars

  def initialize
    @chars = Hash.new{|hash, key| hash[key] = Trie.new }
    @value = nil
  end

  def push(key, value)
    push_recursive(0, key, value)
  end
  alias_method :[]=, :push

  def get(key)
    get_recursive(0, key)
  end
  alias_method :[], :get

  protected
  def push_recursive(index, key, value)
    if(index == key.size)
      @value = value
      value
    else
      chars[key[index]].push_recursive(index+1, key, value)
    end
  end

  def get_recursive(index, key)
    if index == key.size
      value
    elsif chars.key?(key[index])
      chars[key[index]].get_recursive(index+1, key)
    else
      nil
    end
  end
end
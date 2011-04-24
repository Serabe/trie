
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

  def longest_prefix(key)
    longest_prefix_recursive(0, key)
  end

  def wildcard(key)
    wildcard_recursive(0,key.gsub(/\*+/, '*'),"")
  end

  def last?
    !value.nil?
  end

  protected
  def push_recursive(index, key, value)
    if(index == key.size)
      @value = value
      value
    else
      chars[key[index].to_sym].push_recursive(index+1, key, value)
    end
  end

  def get_recursive(index, key)
    if index == key.size
      value
    elsif chars.key?(key[index].to_sym)
      chars[key[index].to_sym].get_recursive(index+1, key)
    else
      nil
    end
  end

  def longest_prefix_recursive(index, key)
    if index == key.size
       key
    elsif chars.key?(key[index].to_sym)
      chars[key[index].to_sym].longest_prefix_recursive(index+1, key)
    else
      key[0,index]
    end
  end

  def wildcard_recursive(index, key, constructed_key)
    if index >= key.size
      last? ? [constructed_key] : []
    elsif key[index] == '*'
      wildcard_recursive(index+1, key, constructed_key) |
          chars.map do |k,v|
            new_key = constructed_key+k.to_s
            v.wildcard_recursive(index, key,new_key) |
                v.wildcard_recursive(index+1,key,new_key)
          end.flatten
    elsif chars.key? key[index].to_sym
      chars[key[index].to_sym].wildcard_recursive(index+1, key, constructed_key+key[index])
    else
      []
    end
  end
end


class Trie
  # Implement a Trie (Prefix Tree) class that supports
  # Lookup, insert and remove method
  attr_accessor :key
  attr_accessor :children

  def initialize(key)
    @key = key
    @children = {}
  end

  # Iteratively lookup a given string in the trie
  def lookup(key)
    if key.nil? or key.empty?
      return true
    end
    node = self
    len = key.length
    i = 0
    while (i < len)
      if not node.children.has_key? key[i]
        return false
      end
      node = node.children[key[i]]
      i += 1
    end
    return true
  end

  # Iteratively insert a given string in the trie
  def insert(key)
    if key.nil? or key.empty?
      return
    end
    node = self
    len = key.length
    i = 0
    while (i < len)
      if not node.children.has_key? key[i]
        break
      end
      node = node.children[key[i]]
      i += 1
    end

    while (i < len)
      new_node = Trie.new(key[i])
      node.children[key[i]] = new_node
      node = new_node
      i += 1
    end
  end

  # Recursively remove string from the trie
  def remove(key)
    if key.nil? or key.empty?
      return true
    end
    if not @children.has_key? key[0] or not @children[key[0]].remove(key[1, key.length - 1])
      return false
    end
    if @children[key[0]].children.empty?
      @children.delete(key[0])
    end
    return true
  end

  def print_node(prefix)
    str = prefix + key
    puts str
    @children.each do |key, value|
      value.print_node(str)
    end
  end

end

trie = Trie.new('')
trie.insert('nitingup')
trie.insert('nitinjup')
trie.remove('nitinjup')
trie.print_node('')
puts trie.lookup('n')

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
    len = key.length
    i = 0
    node = self
    while(i < len)
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
    while(i < len)
      if not node.children.has_key? key[i]
        break
      end
      node = node.children[key[i]]
      i += 1
    end

    while(i < len)
      new_node = Trie.new(key[i])
      node.children[key[i]] = new_node
      node = new_node
      i += 1
    end
  end

end

trie = Trie.new('')
trie.insert(' ')
trie.insert('dhariabi')
trie.insert('nitingup')
puts trie.lookup(' ')

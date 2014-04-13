require './tree_node.rb'

class Trie < TreeNode
  # Implement a Trie (Prefix Tree) class that supports
  # Lookup, insert and remove method

  attr_accessor :is_word

  def initialize(key)
    super(key)
    @is_word = false
  end

  # Iteratively lookup a given string in the trie
  def lookup(key)
    return true if key.nil? or key.empty?
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
    return node.is_word?
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

    # Set the is_word flag to true if reached the end of the word
    node.is_word = true if(i == len)
  end

  # Recursively remove string from the trie
  def remove(key)
    if key.nil? or key.empty?
      @is_word = false
      return true
    end
    if not @children.has_key? key[0] or not @children[key[0]].remove(key[1, key.length - 1])
      return false
    end
    @children.delete key[0] if @children[key[0]].has_children?
    return true
  end

  def print_node(prefix)
    str = prefix + key
    puts str
    @children.each do |key, value|
      value.print_node(str)
    end
  end

  def has_children?
    return @children.empty?
  end

  def is_word?
    @is_word
  end
end

trie = Trie.new('')
trie.insert('nitingup')
trie.insert('nitinjup')
trie.insert('nit')
trie.insert('ni')
trie.remove('nitinjup')
trie.remove('ni')
trie.print_node('')
puts trie.lookup('ni')
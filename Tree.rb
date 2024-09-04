require_relative 'Node.rb'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    root = Node.new(array[mid])

    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid+1..-1])

    root
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # Node with one or no child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Node with two children
      min_larger_node = find_min(node.right)
      node.data = min_larger_node.data
      node.right = delete(min_larger_node.data, node.right)
    end

    node
  end

  def find(value, node = @root)
    return nil if node.nil?

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      node
    end
  end

  def level_order(node = @root, &block)
    return if node.nil?

    queue = [node]
    result = []

    until queue.empty?
      current_node = queue.shift
      block_given? ? yield(current_node) : result << current_node.data

      queue << current_node.left unless current_node.left.nil?
      queue << current_node.right unless current_node.right.nil?
    end

    result unless block_given?
  end

  def inorder(node = @root, &block)
    return if node.nil?

    result = []
    result += inorder(node.left, &block) if node.left
    block_given? ? yield(node) : result << node.data
    result += inorder(node.right, &block) if node.right

    result unless block_given?
  end

  def preorder(node = @root, &block)
    return if node.nil?

    result = []
    block_given? ? yield(node) : result << node.data
    result += preorder(node.left, &block) if node.left
    result += preorder(node.right, &block) if node.right

    result unless block_given?
  end

  def postorder(node = @root, &block)
    return if node.nil?

    result = []
    result += postorder(node.left, &block) if node.left
    result += postorder(node.right, &block) if node.right
    block_given? ? yield(node) : result << node.data

    result unless block_given?
  end

  def height(node = @root)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    [left_height, right_height].max + 1
  end

  def depth(node, root = @root, current_depth = 0)
    return -1 if root.nil?

    return current_depth if node == root

    if node.data < root.data
      depth(node, root.left, current_depth + 1)
    else
      depth(node, root.right, current_depth + 1)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    (left_height - right_height).abs <= 1 &&
      balanced?(node.left) &&
      balanced?(node.right)
  end

  def rebalance
    values = inorder
    @root = build_tree(values)
  end

  def find_min(node)
    node = node.left until node.left.nil?
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

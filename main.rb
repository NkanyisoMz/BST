require_relative 'Tree.rb'

# Create a binary search tree from an array of random numbers
bst = Tree.new(Array.new(15) { rand(1..100) })

# Confirm that the tree is balanced
puts "Is the tree balanced? #{bst.balanced?}"

# Print out all elements in level, pre, post, and in order
puts "Level Order: #{bst.level_order}"
puts "Preorder: #{bst.preorder}"
puts "Postorder: #{bst.postorder}"
puts "Inorder: #{bst.inorder}"

# Unbalance the tree by adding several numbers > 100
[101, 102, 103, 104, 105].each { |value| bst.insert(value) }

# Confirm that the tree is unbalanced
puts "Is the tree balanced? #{bst.balanced?}"

# Rebalance the tree
bst.rebalance

# Confirm that the tree is balanced
puts "Is the tree balanced? #{bst.balanced?}"

# Print out all elements in level, pre, post, and in order
puts "Level Order: #{bst.level_order}"
puts "Preorder: #{bst.preorder}"
puts "Postorder: #{bst.postorder}"
puts "Inorder: #{bst.inorder}"

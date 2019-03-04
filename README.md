# Ruby on Rails 
## Algorithm Practice & Challenges
### Binary Search Trees in Ruby
#### The BST is made up of nodes that have three main features:
 1.They contain a value
 2.They can refer to another node to the left with a smaller value
 3.They can refer to another node to the right with a larger value
###### Implementation :
 My first implementation of this had an overarching Tree class, but it soon became clear that it’s entirely unccessary. As a 
 recursive data structure, each node has a tree descending from it, so we just need a Node. The tree will be implied.

```bash
 module BinaryTree
  class Node
    # our three features:
    attr_reader :value
    attr_accessor :left, :right

    def initialize(v)
      @value = v
    end
  end
end

tree       = BinaryTree::Node.new(10)
tree.left  = BinaryTree::Node.new(5)
tree.right = BinaryTree::Node.new(15)
puts tree.inspect
#<BinaryTree::Node:0x007f9ce207a770 @value=10, 
# @left=#<BinaryTree::Node:0x007f9ce207a748 @value=5>, 
# @right=#<BinaryTree::Node:0x007f9ce207a720 @value=15>>
```

Great! But also: awful. Instead of constructing the tree manually, we need to be able to treat it as if it were an array. We should be able to apply the shovel operator to the base node of the tree and have the tree place the value wherever it should rightfully or leftfully go.

```bash
 module BinaryTree
  class Node
    def insert(v)
      case value <=> v
      when 1 then left.insert(v)
      when -1 then right.insert(v)
      when 0 then false # the value is already present
      end
    end
  end
end
```

This uses Ruby’s spaceshipesque comparator <=> to determine if the value to be inserted is greater than, less than, or equal to the value of the current node, and then traverses the tree until …
 
```bash

tree.insert(3)
# => binary_tree.rb:13:in `insert': undefined method `insert' for nil:NilClass (NoMethodError)
```

Spectacular! Except: not. We have a node that expected its left value to respond to insert, to which nil annoyingly refused. We can redefine more specific insert methods to work around this issue (and, since it’s getting a bit hard to read, a new inspect method):

```bash
module BinaryTree
  class Node
    def insert(v)
      case value <=> v
      when 1 then insert_left(v)
      when -1 then insert_right(v)
      when 0 then false # the value is already present
      end
    end

    def inspect
      "{#{value}::#{left.inspect}|#{right.inspect}}"
    end

    private

      def insert_left(v)
        if left
          left.insert(v)
        else
          self.left = Node.new(v)
        end
      end

      def insert_right(v)
        if right
          right.insert(v)
        else
          self.right = Node.new(v)
        end
      end
  end
end

tree.insert(3)
# => {10:{5:{3:nil|nil}|nil}|{15:nil|nil}}
```
The next step is to determine whether our tree contains a given value. This is where the Binary Search Tree has a reputation for speediness – unlike iterating over every element of an array and checking for equality, the structure of the tree provides a sort of automatic index that points us to where the value should be, and then we can check if it’s there. It’ll look remarkably similar to our insert method:

```bash
module BinaryTree
  class Node

    # named include? to parallel Array#include?
    def include?(v)
      case value <=> v
      when 1 then left.include?(v)
      when -1 then right.include?(v)
      when 0 then true # the current node is equal to the value
      end
    end
  end
end
```
If you were paying attention to the insert method, you can probably guess that when this method reaches a left or right that is nil, it will fail. Which is really annoying! But since this seems to be a pattern we have stumbled upon, let’s find a better way to solve this rather than peppering the code with nil checks. Enter our second class, EmptyNode:

```bash

module BinaryTree
  class EmptyNode
    def include?(*)
      false
    end

    def insert(*)
      false
    end

    def inspect
      "{}"
    end
  end
end

```

…and make sure instances of this class terminate our tree by default:

```bash
module BinaryTree
  class EmptyNode
    def initialize(v)
      @value = v
      @left  = EmptyNode.new
      @right = EmptyNode.new
    end
  end
end

happy = BinaryTree.new(10).left #=> 

```



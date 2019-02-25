# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} p
# @param {TreeNode} q
# @return {Boolean}
def is_same_tree(p, q)
    if p == nil or q == nil
        return p == q
    end
    return ((p.val == q.val) and (is_same_tree(p.left, q.left)) and (is_same_tree(p.right, q.right)))
end
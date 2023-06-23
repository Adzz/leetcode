# Definition for a binary tree node.
#
defmodule TreeNode do
  @type t :: %__MODULE__{
          val: integer,
          left: TreeNode.t() | nil,
          right: TreeNode.t() | nil
        }
  defstruct val: 0, left: nil, right: nil
end

defmodule Solution do
  @doc """
  Inverting a tree seems to be just swapping the left and right nodes. The catch here is
  that it's easier to do from the bottom out so two options are:
    1. Build up a list of the nodes we hope to see then reduce that into a tree
       breadth first starting at the bottom
    2. Try to do it depth first?
  """
  def invert_tree(nil), do: nil

  def invert_tree(root) do
    left = root.left
    right = root.right

    if is_nil(left) && is_nil(right) do
      %TreeNode{
        val: root.val,
        left: root.right,
        right: root.left
      }
    else
      inverted_left = invert_tree(left)
      inverted_right = invert_tree(right)

      %TreeNode{
        val: root.val,
        left: inverted_right,
        right: inverted_left
      }
    end
  end
end

defmodule Solution2 do
  def invert_tree(nil), do: nil

  def invert_tree(tree_node) do
    %TreeNode{
      val: tree_node.val,
      left: invert_tree(tree_node.left),
      right: invert_tree(tree_node.right)
    }
  end
end

defmodule Main do
  def run() do
    %TreeNode{
      val: 4,
      left: %TreeNode{
        val: 2,
        left: %TreeNode{val: 1, left: nil, right: nil},
        right: %TreeNode{val: 3, left: nil, right: nil}
      },
      right: %TreeNode{
        val: 7,
        left: %TreeNode{val: 6, left: nil, right: nil},
        right: %TreeNode{val: 9, left: nil, right: nil}
      }
    }
    |> Solution.invert_tree()
    |> IO.inspect(limit: :infinity, label: "")
  end
end

Main.run()

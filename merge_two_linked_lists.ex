defmodule ListNode do
  defstruct [:val, :next]
end

defmodule Solution do
  @spec merge_two_lists(list1 :: ListNode.t() | nil, list2 :: ListNode.t() | nil) ::
          ListNode.t() | nil
  def merge_two_lists(nil, nil), do: nil

  def merge_two_lists(list1, list2) do
    [last_value | rest] = node_order(list1, list2, [])

    rest
    |> Enum.reduce(%ListNode{val: last_value}, fn value, linked_list ->
      %ListNode{val: value, next: linked_list}
    end)
  end

  defp node_order(nil, nil, result) do
    result
  end

  defp node_order(list1, nil, result) do
    node_order(list1.next, nil, [list1.val | result])
  end

  defp node_order(nil, list2, result) do
    node_order(nil, list2.next, [list2.val | result])
  end

  defp node_order(list1, list2, result) do
    if list1.val <= list2.val do
      node_order(list1.next, list2, [list1.val | result])
    else
      node_order(list1, list2.next, [list2.val | result])
    end
  end
end

defmodule Runner do
  def main() do
    left = %ListNode{val: 1, next: %ListNode{val: 3, next: nil}}
    right = %ListNode{val: 2, next: %ListNode{val: 4, next: nil}}

    Solution.merge_two_lists(left, right)
    |> IO.inspect(limit: :infinity, label: "")
  end
end

Runner.main()

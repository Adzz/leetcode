defmodule ListNode do
  @type t :: %__MODULE__{
          val: integer,
          next: ListNode.t() | nil
        }
  defstruct val: 0, next: nil
end

defmodule Solution do
  @spec add_two_numbers(l1 :: ListNode.t() | nil, l2 :: ListNode.t() | nil) :: ListNode.t() | nil
  def add_two_numbers(l1, l2) do
    reversed_digits = digit_addition(l1, l2, 0, [])

    tl(reversed_digits)
    |> Enum.reduce(%ListNode{val: hd(reversed_digits)}, fn digit, prev_node ->
      %ListNode{val: digit, next: prev_node}
    end)
  end

  defp digit_addition(nil, nil, 0, result) do
    result
  end

  defp digit_addition(nil, nil, carry, result) do
    [carry | result]
  end

  defp digit_addition(nil, l2, carry, result) do
    added = l2.val + carry
    carry = if added >= 10, do: 1, else: 0
    digit_addition(nil, l2.next, carry, [added - carry * 10 | result])
  end

  defp digit_addition(l1, nil, carry, result) do
    added = l1.val + carry
    carry = if added >= 10, do: 1, else: 0
    digit_addition(l1.next, nil, carry, [added - carry * 10 | result])
  end

  defp digit_addition(l1, l2, carry, result) do
    added = l1.val + l2.val + carry
    carry = if added >= 10, do: 1, else: 0
    digit_addition(l1.next, l2.next, carry, [added - carry * 10 | result])
  end
end

defmodule Main do
  def run() do
    # l1 = [2,4,3], l2 = [5,6,4]
    # [7, 0, 8]
    %ListNode{val: 2, next: %ListNode{val: 4, next: %ListNode{val: 3}}}
    |> Solution.add_two_numbers(%ListNode{
      val: 5,
      next: %ListNode{val: 6, next: %ListNode{val: 4}}
    })
    |> IO.inspect(limit: :infinity, label: "1")

    %ListNode{val: 9, next: %ListNode{val: 9, next: %ListNode{val: 9}}}
    |> Solution.add_two_numbers(%ListNode{val: 9, next: %ListNode{val: 9}})
    |> IO.inspect(limit: :infinity, label: "3")
  end
end

Main.run()

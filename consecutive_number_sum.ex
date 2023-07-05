defmodule Solution do
  @moduledoc """
  https://leetcode.com/problems/consecutive-numbers-sum

  """
  @doc """
  """
  def consecutive_numbers_sum(2), do: 1
  def consecutive_numbers_sum(1), do: 1
  def consecutive_numbers_sum(0), do: 0

  def consecutive_numbers_sum(n) do
    longest_chain_length = longest_chain(1, div(n, 2) + 1, n)
    longest_chain_length |> IO.inspect(limit: :infinity, label: "ll")
    # If the largest number of consecutive integers is 2 then there will not be a 3 chain
    # of ints so stop immediately.
    if longest_chain_length <= 2 do
      longest_chain_length
    else
      {total, _} =
        (longest_chain_length - 1)..2
        |> Enum.reduce({2, 1}, fn max_chain_length, {total, min_starting_value} ->
          max_starting_value = div(n, max_chain_length)

          if min_starting_value > max_starting_value do
            {total, min_starting_value}
          else
            search_chain_size(
              min_starting_value,
              max_chain_length,
              min_starting_value,
              max_starting_value,
              n,
              total
            )
          end
        end)

      total
    end
  end

  defp longest_chain(starting_value, max_starting_value, target) do
    case sum_with_count(starting_value, max_starting_value, 0, 0, target) do
      :bust -> longest_chain(starting_value + 1, max_starting_value, target)
      int_count -> int_count
    end
  end

  # Probably this can be improved... probably by binary searching the starting value.
  defp sum_with_count(head, max_starting_value, running_total, int_count, target) do
    current = head + running_total

    if current > target do
      :bust
    else
      if current < target do
        next = head + 1

        if next <= max_starting_value do
          sum_with_count(next, max_starting_value, current, int_count + 1, target)
        else
          :bust
        end
      else
        int_count + 1
      end
    end
  end

  defp search_chain_size(starting_value, _, min_starting_value, max_starting_value, _, total)
       when starting_value > max_starting_value do
    {total, min_starting_value}
  end

  defp search_chain_size(
         starting_value,
         chain_length,
         min_starting_value,
         max_starting_value,
         target,
         total
       ) do
    chain_total = chain_length / 2 * (starting_value + (starting_value + (chain_length - 1)))

    if chain_total > target do
      # Is there a way to bust out faster for a given window size?
      {total, starting_value + 1}
    else
      if chain_total == target do
        {total + 1, starting_value + 1}
      else
        # chain_total < target
        search_chain_size(
          starting_value + 1,
          chain_length,
          min_starting_value,
          max_starting_value,
          target,
          total
        )
      end
    end
  end
end

defmodule Main do
  def run() do
    5
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "1 Answer (should be 2):")

    9
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "2 Answer (3):")

    15
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "3 Answer (4):")

    3
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "4 Answer (2):")

    10
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "5 Answer (2):")

    45
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "5.1 Answer (6):")

    5_809_342
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "6 Answer (24):")

    72_316_829
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "7 Answer:")

    4
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "8 Answer (1):")
  end
end

Main.run()

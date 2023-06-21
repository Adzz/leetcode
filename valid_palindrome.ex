defmodule ValidPalindrome do
  def is_palindrome(string) do
    sanitized =
      string
      |> String.downcase()
      |> String.replace(~r/[^a-z0-9]/, "")

    String.reverse(sanitized) == sanitized
  end
end

ValidPalindrome.is_palindrome("A man, a plan, a canal: Panama")
|> IO.inspect(limit: :infinity, label: "")

ValidPalindrome.is_palindrome("A man, a plan, a canal: Panama nawTSDknd['3284u5y7t376")
|> IO.inspect(limit: :infinity, label: "")

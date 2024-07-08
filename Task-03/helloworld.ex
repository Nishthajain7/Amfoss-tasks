defmodule BinarySearch do
  def search(array, target) do
    IO.puts "Array: #{inspect(array)}"
    IO.puts "Target: #{target}"
    binary_search(array, target, 0, length(array) - 1)
  end

  defp binary_search(array, target, low, high) when low <= high do
    mid = div(low + high, 2)
    case Enum.at(array, mid) do
      mid_value when mid_value == target ->
        IO.puts "Target found at index #{mid}."
        mid;
      mid_value when mid_value > target ->
        binary_search(array, target, low, mid - 1);
      _ ->
        binary_search(array, target, mid + 1, high)
    end
  end

  defp binary_search(_, _, _, _) do
    IO.puts "Target not found."
    -1
  end
end

array = [1, 3, 5, 7, 9, 11, 13]
target = 7
BinarySearch.search(array, target)

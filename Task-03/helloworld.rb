def binary_search(arr, target)
  low = 0
  high = arr.length - 1
  
  while low <= high
    mid = (low + high) / 2
    guess = arr[mid]
    
    if guess == target
      return mid
    elsif guess > target
      high = mid - 1
    else
      low = mid + 1
    end
  end
  
  return -1  # If target not found
end

sorted_array = [1, 3, 5, 7, 9, 11, 13, 15]
target_value = 7

index = binary_search(sorted_array, target_value)

if index != -1
  puts "Target value #{target_value} found at index #{index} in array #{sorted_array}."
end

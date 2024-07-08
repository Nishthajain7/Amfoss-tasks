package main

import (
	"fmt"
)

func binarySearch(arr []int, target int) (int, bool) {
	low, high := 0, len(arr)-1

	for low <= high {
		mid := (low + high) / 2
		guess := arr[mid]

		if guess == target {
			return mid, true
		}

		if guess > target {
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return -1, false
}

func main() {
	array := []int{1, 3, 5, 7, 9, 11, 13, 15, 17, 19}
	target := 11

	fmt.Printf("Array: %v\n", array)
	fmt.Printf("Target: %d\n", target)

	index, found := binarySearch(array, target)
	if found {
		fmt.Printf("Target %d found at index %d\n", target, index)
	} else {
		fmt.Printf("Target %d not found in the array\n", target)
	}
}

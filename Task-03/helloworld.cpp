#include <iostream>
#include <vector>

void printArray(const std::vector<int>& arr) {
    std::cout << "Array: [";
    for (size_t i = 0; i < arr.size(); ++i) {
        std::cout << arr[i];
        if (i < arr.size() - 1) {
            std::cout << ", ";
        }
    }
    std::cout << "]" << std::endl;
}

int binarySearch(const std::vector<int>& arr, int target) {
    int left = 0;
    int right = arr.size() - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;

        if (arr[mid] == target) {
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return -1; // To return -1 if the target is not found
}

int main() {
    std::vector<int> arr = {1, 2, 4, 5, 7, 8, 9, 12, 15, 18, 21};
    int target = 7;

    printArray(arr);
    std::cout << "Target: " << target << std::endl;

    int result = binarySearch(arr, target);

    if (result != -1) {
        std::cout << "Target found at index: " << result << std::endl;
    } 
}

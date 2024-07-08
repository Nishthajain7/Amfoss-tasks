fn binary_search(arr: &[i32], target: i32) -> Option<usize> {
    let mut left = 0;
    let mut right = arr.len() - 1;

    while left <= right {
        let mid = left + (right - left) / 2;

        if arr[mid] == target {
            return Some(mid);
        } else if arr[mid] < target {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    None // If target not found
}

fn main() {
    let arr = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
    let target = 13;

    println!("Array: {:?}", arr);
    println!("Target: {}", target);

    match binary_search(&arr, target) {
        Some(index) => println!("Target found at index {}", index),
        None => println!("Target not found in the array"),
    }
}

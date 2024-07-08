def binary_search(array, target):
    lower=0
    upper=len(array)-1
    
    while lower <= upper:
        mid = upper + lower // 2
        if array[mid] == target:
            return mid
        elif array[mid] < target:
            lower = mid + 1
        else:
            upper = mid - 1

array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
target = 7
result = binary_search(array, target)
print('Array: '+str(array))
print(f'Target is {target}')
print(f"Target found at index: {result}")

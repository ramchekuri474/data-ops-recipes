# This code defines a tuple representing geographical coordinates and uses it as a key in a dictionary to map to a location name.
coordinates = (42.65, -79.38)
print(coordinates)

location_map = {
    coordinates: "Toronto"
}

print(location_map)

# Output:
# (42.65, -79.38)
# {(42.65, -79.38): 'Toronto'}

print(type(coordinates))  # This will print: <class 'tuple'>

# Demonstrating immutability of tuples
try:
    coordinates[0] = 43.65  # This will raise a TypeError
except TypeError as e:
    print("Error:", e)
# Output: Error: 'tuple' object does not support item assignment
print(location_map)
# Output: {(42.65, -79.38): 'Toronto'}

# Task:Check if employee 999 exists.
employee_ids = list(range(1, 100000))
employee_set = set(employee_ids)

print(999 in employee_set)  # This will print: True
# Output: True
print(100000 in employee_set)  # This will print: False
# Output: False
# range(1, 100000) creates a sequence of numbers from 1 to 99999.
# Converting this range to a list stores all these numbers in memory.
# thats why when you asked for 100000 it returned false because it is not in the list.
# Python ranges are half-open, meaning they include the start value but exclude the end value.

# final list should contain unique IDs only.
employee_ids_with_duplicates = [1, 2, 3, 4, 5, 3, 2, 1]
print(employee_ids_with_duplicates)  # This will print: [1, 2, 3, 4, 5, 3, 2, 1]
unique_employee_ids = set(employee_ids_with_duplicates)
# A set stores only unique values by design.
print(unique_employee_ids)  # This will print: {1, 2, 3, 4, 5}
# Output: {1, 2, 3, 4, 5}
# Converting the list to a set removes duplicates because sets cannot contain duplicate values.

# Sets require hashable elements, and lists are mutable and unhashable, so allowing them would break the set’s internal hashing mechanism.
try:
    invalid_set = {1, 2, [3, 4]}  # This will raise a TypeError
except TypeError as e:
    print("Error:", e)
# Output: Error: unhashable type: 'list'    
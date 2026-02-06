amount = 10
print(type(amount))  # This will print: <class 'int'>)
# Determine the sale category based on the amount

if amount > 100:
    print("High value sale")
elif amount > 50:
    print("Medium value sale")
else:
    print("Low value sale")
    # Output: Low value sale,depends on the value of amount, in this case it is 10 which is less than 50.

# Comparison operators return boolean values (True or False) based on the relationship between the operands.
x = 10
y = 20

print(x > y)      # False
print(x <= y)     # True
print(x == y)     # False
print(x != y)     # True

# Logical operators combine boolean expressions and return a boolean result based on the logic of the expressions.
amount = 90

if amount > 100 and amount < 500:
    print("Valid amount")
elif amount <100 and amount>50:
    print("Amount is low")
else:
    print("Amount is too low")
# Output: Amount is low, because the amount is less than 100 and greater than 50.

# for loop iterates over a sequence (like a list, tuple, or string) and executes a block of code for each item in the sequence.
fruits = ["apple", "banana", "cherry"]
# this loop will print each fruit in the list one by one.
for fruit in fruits:
    print(fruit)
# Output:
# apple
# banana
# cherry

# loop over a list
sales = [100, 200, 50, 300]

for s in sales:
    print(s)
# Output:
# 100
# 200
# 50
# print only sales greater than 100
for s in sales:
    if s > 100:
        print(s)
# Output:
# 200
# 300   

# range function generates a sequence of numbers, which is often used in for loops to iterate a specific number of times.
# Print numbers from 0 to 4,usually range starts from 0 and goes up to but does not include the specified end value.
for i in range(5):
    print(i)
# Output:
# 0
# 1
# 2
# 3
# 4
# Print numbers from 1 to 5
for i in range(1, 6):
    print(i)
# Output:
# 1
# 2
# 3     
# 4
# 5     
# enumerate function adds a counter to an iterable and returns it as an enumerate object, which can be used in a for loop to get both the index and the value of each item in the iterable.
fruits = ["apple", "banana", "cherry"]
for index, fruit in enumerate(fruits):
    print(f"Index: {index}, Fruit: {fruit}")
# Output:
# Index: 0, Fruit: apple
# Index: 1, Fruit: banana
# Index: 2, Fruit: cherry   

employees = ["Alice", "Bob", "Carol"]

for index, name in enumerate(employees):
    print(index, name)
# Output:
# 0 Alice
# 1 Bob
# 2 Carol
# while loop continues to execute a block of code as long as a specified condition is true.
count = 0
while count < 5:
    print(count)
    count += 1  # This increments count by 1 each iteration
# Output:
# 0
# 1
# 2
# 3
# 4 
count = 0

while count < 3:
    print("Processing item", count)
    count += 1
# Output:
# Processing item 0
# Processing item 1 
# Processing item 2 
# break statement exits the nearest enclosing loop, skipping any remaining iterations.
for i in range(10):
    if i == 5:
        break  # Exit the loop when i is 5
    print(i)
# Output:
# 0
# 1
# 2
# 3
# 4
# since when s==50 the loop will break and not print 50 or 300.
sales = [100, 200, 50, 300]
for s in sales:
    if s == 50:
        break
    print(s)
# Output:
# 100
# 200   
# continue statement skips the current iteration of the loop and moves to the next iteration.
for s in sales:
    if s == 50:
        continue
    print(s)
# Output:
# 100
# 200
# 300
# since when s==50 the loop will skip that iteration and continue with the next one.

# real data engineering example for for loop
# filter valid employee ids from a list
employee_ids = [1, 2, None, 3, None, 4]

valid_ids = []

for eid in employee_ids:
    if eid is not None:
        valid_ids.append(eid)

print(valid_ids)
# Output: [1, 2, 3, 4]
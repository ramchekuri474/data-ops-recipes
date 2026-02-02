# Integers
age = 30

# Floating point numbers
salary = 105000.75

# String
name = "Ram"

# Boolean
is_active = True

print(type(age), age)
print(type(salary), salary)
print(type(name), name)
print(type(is_active), is_active)

#list,A list is an ordered, mutable collection of elements.
#can be modified once created
sales = [100, 200, 150]

sales.append(300)        # add element,this will add element at the end of the list
sales[0] = 120           # modify element,this will change the first element of the list

print(sales)
print(type(sales), sales)

# Tuple,A tuple is an ordered, immutable collection of elements.
#Cannot be changed after creation

#Safer for fixed data

coordinates = (10, 20)

print(coordinates)

print(type(coordinates), coordinates)

#set,A set is an unordered collection of unique elements.
#No duplicate values allowed,if you try to add a duplicate,it will be ignored
employee_ids = {1, 2, 2, 3, 4, 4}

print(employee_ids)
print(type(employee_ids), employee_ids)

# Dictionary,A dictionary is an unordered collection of key-value pairs.
#Keys must be unique,values can be of any data type
employee = {
    "id": 1,
    "name": "Alice",
    "dept": "Data"
}
print(employee)
print(type(employee), employee)

employee["location"] = "Toronto"   # add new key
employee["dept"] = "Analytics"     # update value
print(employee)

# Demonstrating mutability with lists,in a list,modifications affect all references to that list
# Both a and b will reflect the change since they reference the same list
a = [1, 2, 3]
b = a

a.append(4)

print("a:", a)
print("b:", b)

# integers are immutable, and reassignment creates a new object.
x = 10
y = x


x = 20 # reassign x to a new integer value,here it will not modiy it create a new object

print(x)
# 20
print(y)
# 10

# Demonstrating mutability with lists,in a list,modifications affect all references to that list
# Both a and b will reflect the change since they reference the same list
a = [1, 2, 3]
b = a

a.append(4)

print(a)
print(b)

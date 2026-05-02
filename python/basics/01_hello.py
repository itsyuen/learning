# First program in Python

## practice numbners, string and lists
print("Hello Peter")

name = "Peter"
print("Welcome,", name)

# in console, you can run this file with the command: python 01_hello.py

2+3     # in script mode this does nothing
2*3
2/3
print(2+3)  # only this works
print(2*3)
print(2/3)

# not in python perl interpreter mode, nothing shows up for the above calculations, but in python interactive mode, the results will be printed out immediately.

x = 10
y = 20  

z = x + y
print("x is:", x)
print("y is:", y)
print("The sum of x and y is:", z)

# Python also has built-in support for complex numbers, and uses the j or J suffix to indicate the imaginary part (e.g. 3+5j).

# string practice for connacting strings together
first_name = "Peter"
last_name = " Chang"
name = first_name + last_name
print("Hello", name)

# practicing lists, like array in c, 
snumber = [1, 2, 33, 55, 99, -1, 201]
print("a list of numbers:", snumber)
print("first list in snumber list:", snumber[0])   # remember array numbering is c/c++ like start with zero!
print("last list in snumber list:", snumber[-1])
print("part of list in snumber[2:4]:", snumber[2:4])

sothernumber = [3.1415, 2.819, -33+22j]
print("some other number list:", sothernumber)
wholenumber = snumber+sothernumber  # added more complex number to list called another number list 
print("add the two list together:", wholenumber)
print("last entry of the new list:", wholenumber[-1])
partnumber = wholenumber[6:-1]  # this ommits last number
print("size of partnumber list for [6:-1]: ", len(partnumber))
print("they are:", partnumber)
partnumber = wholenumber[6:]
print("size of partnumber list for [6:]: ", len(partnumber))
print("they are:", partnumber)
partnumber = wholenumber[-3:]
print("size of partnumber list for [-3:]: ", len(partnumber))
print("they are:", partnumber)

# replacing or deleting number in lists
print("original wholenumber:", wholenumber)
wholenumber[9] = 0 # change last complex number to zero
print("new wholenumber:", wholenumber)
print("current partnumber:", partnumber)
partnumber = partnumber[0:1]
print("the self cut partnumber[0:1] list is now: ", partnumber)
print("while cutting only two adjecent index like list[1:2],"
      "feels just like list[1] but the former one is a list, and the later one is a number call!")

# appending list for string objects
rgb = ["Red", "Green", "Blue"]
rgba = rgb
rgba.append("alph")
print(rgb)  # they are the same thing, no data copies

a = ['a','b','c']
n = [1, 2, 3]
x = [a, n]
print(x[0])
print(x[0][1])
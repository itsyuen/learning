# definition library for robot_tools that is meant to teach/learn libraries

def check_datatype(data):
    print("Checking input data type:")
    return type(data)

def string_to_float(some_string):
    print("changing data type to float")
    some_float = float(some_string)
    return some_float
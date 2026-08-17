# MATLAB--Python Runtime and Communication Architecture

## Purpose

This note separates three ideas that can easily look similar when first
learning MATLAB--Python integration:

1. MATLAB executing Python code with `pyrun()` or `pyrunfile()`.
2. MATLAB accessing Python objects and modules.
3. Two truly independent programs communicating through an explicit
    channel.

The current teaching environment is:

``` text
Windows 11
├── MATLAB R2026a
├── Python 3.13
└── WSL2 Ubuntu
    └── ROS 2
```

For the first stage, MATLAB and Python stay entirely on Windows. ROS 2
remains in WSL2 for later work.

------------------------------------------------------------------------

## 1. A Simple Python File

Example Python file:

``` python
# b02_python_list_example.py

numbers = [1, 2, 3, 4]
mixed = [1, "peter", 3.14, True]

numberss = [float(x) for x in numbers]
```

After Python executes the file:

``` python
numbers
# [1, 2, 3, 4]

numberss
# [1.0, 2.0, 3.0, 4.0]
```

`numberss` is still a Python `list` object, but its contained elements
are Python `float` objects.

``` python
type(numberss)
# list

type(numberss[0])
# float
```

This gives an early object-oriented idea without needing to introduce
classes or inheritance yet:

``` text
Python list object
└── contains Python float objects
```

------------------------------------------------------------------------

## 2. `pyrun()` --- Execute Python Statements

MATLAB can ask its configured Python interpreter to execute Python
statements:

``` matlab
pyX = pyrun("x = [float(10), float(9), float(8)]", "x");
```

Conceptually:

``` text
MATLAB
   |
   | pyrun("Python statements", "requested_variable")
   v
Python interpreter
   |
   | creates Python objects
   v
requested Python object
   |
   v
MATLAB variable
```

`pyX` is the MATLAB-side variable receiving the requested Python object.

A useful description is:

> `pyrun()` executes Python statements and can return a selected Python
> object to MATLAB.

------------------------------------------------------------------------

## 3. `pyrunfile()` --- Execute a Whole Python Script

Instead of placing Python statements inside MATLAB, MATLAB can execute a
complete `.py` file:

``` matlab
pyList = pyrunfile("b02_python_list_example.py", "numberss");
```

The important order is:

``` text
execute b02_python_list_example.py
             ↓
numbers = [1, 2, 3, 4]
             ↓
numberss = [1.0, 2.0, 3.0, 4.0]
             ↓
request Python variable "numberss"
             ↓
MATLAB variable pyList
```

Therefore the conversion to `float` happens **inside Python before
MATLAB receives `numberss`**.

A useful description is:

> `pyrunfile()` executes a Python script and can return selected objects
> created by that script.

------------------------------------------------------------------------

## 4. Importing the File as a Python Module Object

A Python file can also be imported as a module:

``` matlab
pyList = pyrun( ...
    "import b02_python_list_example as p; result = p.numberss", ...
    "result");
```

Note that Python import syntax uses the module name **without `.py`**:

``` python
import b02_python_list_example as p
```

not:

``` python
import b02_python_list_example.py as p
```

The object relationships are:

``` text
b02_python_list_example
        |
        v
Python module object
        |
        +-- numbers
        +-- mixed
        +-- numberss
               |
               v
       Python list object
               |
               v
            result
               |
               v
       MATLAB pyList
```

Here `p` is a Python name referring to the imported module object.

Another MATLAB approach is:

``` matlab
p = py.importlib.import_module("b02_python_list_example");

p.numbers
p.mixed
p.numberss
```

Now the MATLAB variable `p` refers to the Python module object, allowing
its members to be accessed repeatedly.

------------------------------------------------------------------------

## 5. `pyrunfile()` and `import` Are Not the Same Operation

These may return the same data:

``` matlab
pyList1 = pyrunfile( ...
    "b02_python_list_example.py", ...
    "numberss");
```

and:

``` matlab
pyList2 = pyrun( ...
    "import b02_python_list_example as p; result = p.numberss", ...
    "result");
```

But the Python operations are conceptually different.

### `pyrunfile()`

``` text
Python file
   ↓
execute script
   ↓
create variables/objects
   ↓
return requested object
```

### `import`

``` text
Python file
   ↓
load/import as module
   ↓
module object p
   ↓
access p.numberss
   ↓
return requested object
```

A compact teaching summary is:

``` text
pyrun()      -> execute Python statements
pyrunfile()  -> execute a Python script
import       -> access code/data through a Python module object
```

------------------------------------------------------------------------

## 6. What Does "Object" Mean Here?

It is useful to introduce the object idea at this point, but only at a
simple level.

For example:

``` text
p                 -> Python module object
p.numberss        -> Python list object
p.numberss[0]     -> Python float object
```

MATLAB can hold references to Python objects using MATLAB variable
names:

``` matlab
pyList = pyrun(...);
```

So:

``` text
Python side                         MATLAB side

numberss
   |
   +-- Python list object  -------> pyList
```

This does **not** mean that `pyList` becomes the name of the Python
variable itself. It is the MATLAB-side variable receiving the Python
object returned through MATLAB's Python interface.

At this stage there is no need to teach constructors, inheritance, or
class design. The important idea is simply:

> Python creates objects, and MATLAB can access selected Python objects.

------------------------------------------------------------------------

# Part II --- Runtime and Process Architecture

## 7. `pyrun()` Is MATLAB-Initiated Python Integration

When MATLAB uses:

``` matlab
pyrun(...)
```

or:

``` matlab
pyrunfile(...)
```

we should not picture two completely independent applications that
somehow discovered each other.

Instead:

``` text
MATLAB
   |
   | MATLAB Python interface
   v
configured Python runtime
```

MATLAB initiates the Python execution and provides the integration
mechanism.

Therefore, **we do not design our own communication protocol** for this
case.

------------------------------------------------------------------------

## 8. Two Truly Independent Processes Are Different

Suppose instead that we independently start:

``` text
MATLAB process                  Python process

MATLAB.exe                      python.exe
    |                               |
    | running independently         | running independently
    |                               |
```

Now neither program automatically has access to the other's variables or
objects.

They require an explicit **inter-process communication (IPC)**
mechanism:

``` text
MATLAB process
      |
      | communication channel
      |
Python process
```

Possible same-computer communication mechanisms include:

- TCP/IP sockets
- UDP
- named pipes
- shared memory
- files
- HTTP/REST
- ZeroMQ
- other messaging middleware

Both programs must agree on things such as:

``` text
address / port
message format
data type
ordering
timing
request / response behavior
```

For example:

``` text
MATLAB                           Python
   |                                |
   |------ data/message ----------->|
   |                                | calculate
   |<----- result/message -----------|
   |                                |
```

Now neither language runtime necessarily owns the other.

------------------------------------------------------------------------

## 9. Software IPC vs Hardware Communication Buses

The idea of a communication "channel" is correct, but it helps to
distinguish software IPC from hardware buses.

For two programs running on the same PC, typical choices are:

``` text
TCP / UDP
pipes
shared memory
files
middleware
```

For communication with embedded hardware, technologies such as these
become relevant:

``` text
CAN
UART / serial
USB
Ethernet
SPI
I2C
```

Therefore:

``` text
MATLAB process <-> Python process
```

is primarily an **IPC/software communication** problem.

Whereas:

``` text
PC <-> STM32 / motor controller / sensor
```

may involve a **hardware communication interface**.

------------------------------------------------------------------------

# Part III --- Current Windows + WSL2 Architecture

## 10. Keep MATLAB and Python on Windows

The current setup does not require installing ROS 2 on Windows or MATLAB
inside WSL2.

For the present MATLAB--Python exercises:

``` text
Windows 11

MATLAB R2026a
      |
      | pyrun / pyrunfile
      v
Windows Python 3.13
```

This is the appropriate environment for learning:

-   Python lists and objects
-   MATLAB cell arrays and numeric arrays
-   Python modules
-   NumPy
-   MATLAB ↔ Python data conversion
-   matrix calculations
-   plotting
-   MATLAB/Python language integration

ROS 2 does not need to enter this stage yet.

------------------------------------------------------------------------

## 11. ROS 2 Can Remain in WSL2

The machine can be thought of as:

``` text
┌──────────────────── Windows 11 ────────────────────┐
│                                                    │
│   MATLAB R2026a  <---->  Windows Python 3.13      │
│                                                    │
│   Current MATLAB–Python teaching environment       │
│                                                    │
│   ┌────────────── WSL2 Ubuntu ─────────────────┐  │
│   │                                             │  │
│   │                 ROS 2                       │  │
│   │                                             │  │
│   │          Python / C++ ROS 2 nodes           │  │
│   │                                             │  │
│   └─────────────────────────────────────────────┘  │
│                                                    │
└────────────────────────────────────────────────────┘
```

This separation is useful rather than a problem.

The Windows MATLAB/Python environment can first teach **language
integration**.

The WSL2 environment can later teach **distributed communication and ROS
2**.

------------------------------------------------------------------------

## 12. Why ROS 2 Becomes Important Later

Once two programs are truly independent, communication requires a
defined architecture.

Without ROS 2, we could build something ourselves:

``` text
MATLAB
   |
   | TCP socket
   |
Python
```

Then we would have to define our own messages and communication
behavior.

ROS 2 addresses this kind of problem at a larger architectural level:

``` text
ROS 2 Node A
     |
     | topics / services / actions
     | standardized messages
     | DDS middleware
     |
ROS 2 Node B
```

The nodes may be separate processes and may be written in different
supported languages.

This leads to an important conceptual transition:

> MATLAB--Python integration is about one environment directly
> executing/accessing another language runtime.

> ROS 2 communication is about independent nodes exchanging standardized
> messages through middleware.

------------------------------------------------------------------------

# 13. Teaching Progression

A useful progression for the course is:

### Level 1 --- Python language objects

``` text
list
float
dictionary
NumPy array
module
```

Learn what Python objects are.

### Level 2 --- MATLAB calls Python

``` text
MATLAB
   |
   +--> pyrun()
   +--> pyrunfile()
   +--> import/module access
```

Learn how MATLAB accesses Python code and objects.

### Level 3 --- MATLAB ↔ Python data

``` text
MATLAB matrix
      ↕
Python list / NumPy array
```

Perform calculations and plots in both environments.

### Level 4 --- Independent processes

``` text
MATLAB process <---- IPC ----> Python process
```

Understand why an explicit communication channel is required.

### Level 5 --- ROS 2

``` text
Node A <---- ROS 2 / DDS ----> Node B
```

Understand standardized distributed communication.

### Level 6 --- Embedded systems

``` text
PC / ROS 2
    |
    | CAN / serial / Ethernet / micro-ROS / etc.
    |
STM32 / motor controller / sensors
```

Connect software architecture to real control hardware.

------------------------------------------------------------------------

# 14. The Main Concept

The important boundary is:

``` text
DIRECT LANGUAGE INTEGRATION
MATLAB -> Python
pyrun / pyrunfile / Python objects

                ↓

INTER-PROCESS COMMUNICATION
MATLAB process <-> Python process
TCP / UDP / pipes / middleware

                ↓

DISTRIBUTED ROBOTICS COMMUNICATION
ROS 2 node <-> ROS 2 node
topics / services / DDS

                ↓

EMBEDDED COMMUNICATION
PC / ROS 2 <-> controller / sensors / actuators
CAN / serial / Ethernet / micro-ROS
```

This provides a natural path from basic Python syntax and MATLAB
integration to the reason ROS 2 and embedded communication architectures
exist.

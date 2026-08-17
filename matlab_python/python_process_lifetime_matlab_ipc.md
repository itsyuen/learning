# Python Process Lifetime and Communication with MATLAB

## 1. Why Process Lifetime Matters

Before discussing MATLAB calling Python with `pyrun` or `pyrunfile`, it
is useful to understand what happens when Python runs as a **standalone
program**.

Consider:

``` python
# b02_python_list_example.py

numbers = [1, 2, 3, 4]
numberss = [float(x) for x in numbers]

print(numberss)
```

If it is launched from PowerShell:

``` powershell
python b02_python_list_example.py
```

the sequence is:

``` text
PowerShell
    |
    +-- python.exe STARTS
    |
    +-- numbers is created
    +-- numberss is created
    |
    +-- script reaches the end
    |
    +-- python.exe STOPS
            |
            +-- Python objects disappear

PS C:\...>       <- PowerShell itself is still alive
```

Clicking **Run Python File** in the VS Code editor normally produces
essentially the same Python process lifetime.

The important distinction is:

> **PowerShell or VS Code can remain open even though the Python process
> has already finished.**

------------------------------------------------------------------------

## 2. Keeping a Python Interpreter or Process Alive

There are several mechanisms for keeping Python alive. For teaching
purposes, three important cases are useful.

### Case 1 --- Interactive Python Interpreter

From PowerShell:

``` powershell
python
```

Python enters interactive mode:

``` text
>>>
```

We can then import the example:

``` python
>>> import b02_python_list_example as p
>>> p.numberss
[1.0, 2.0, 3.0, 4.0]
```

Conceptually:

``` text
python.exe
    |
    +-- interpreter starts
    |
    +-- import b02_python_list_example
    |
    +-- p.numberss exists in memory
    |
    +-- >>>
    |    waiting for another command
    |
    +-- >>>
    |    waiting...
    |
    +-- exit()
```

### Important Point: `import` Does Not Keep Python Alive

`import` loads and executes a module.

It is the **interactive interpreter waiting for another command** that
keeps the Python process alive.

Therefore:

> **The imported module and its objects remain available because the
> Python interpreter remains alive.**

------------------------------------------------------------------------

## 3. A Python Script That Deliberately Keeps Running

A normal Python script exits when it reaches its end.

We can deliberately prevent this:

``` python
# b02_running.py

numbers = [1, 2, 3, 4]
numberss = [float(x) for x in numbers]

print("numberss =", numberss)

input("Python is alive. Press Enter to stop...")
```

Run:

``` powershell
python b02_running.py
```

Now `python.exe` remains alive because `input()` is waiting.

A more realistic engineering application could contain a continuous
loop:

``` python
while True:
    # read sensor
    # update calculation
    # communicate with another system
    pass
```

This type of process appears later in:

- data acquisition
- hardware interfaces
- servers
- control programs
- ROS 2 nodes

Thus, **process lifetime** is not merely a Python programming detail; it
becomes a system architecture concept.

------------------------------------------------------------------------

## 4. Jupyter / IPython Kernel

A Jupyter notebook provides another form of persistent Python process.

``` text
VS Code
   |
   +-- Jupyter kernel
           |
           +-- Cell 1 -> numbers = [...]
           |
           +-- waiting
           |
           +-- Cell 2 -> numberss = [...]
           |
           +-- waiting
           |
           +-- Python objects remain in memory
```

This explains why a variable created in one notebook cell can still be
used by another cell later.

The **kernel remains alive**, so its Python objects remain alive.

------------------------------------------------------------------------

## 5. Three Useful Python Execution Models

  -----------------------------------------------------------------------
  Execution method        Python process          Objects after execution
  ----------------------- ----------------------- -----------------------
  `python program.py`     Starts and then exits   Disappear

  Interactive `python`    Remains alive until     Remain available
  (`>>>`)                 `exit()`                

  Jupyter/IPython kernel  Remains alive           Remain available

  Long-running Python     Remains alive while     Remain available
  script                  program is running      
  -----------------------------------------------------------------------

These are not necessarily the only ways to keep Python alive. They are
useful examples for understanding **process and object lifetime**.

------------------------------------------------------------------------

# 6. The More Interesting MATLAB Experiment

Instead of first allowing MATLAB to start or control Python using:

``` matlab
pyrun(...)
```

or:

``` matlab
pyrunfile(...)
```

consider a different experiment:

> **Start Python independently first, keep it running, and then ask
> whether MATLAB can see its Python objects.**

For example:

``` text
        TWO INDEPENDENT PROCESSES

Python started externally                MATLAB
-------------------------          ------------------

python.exe                         MATLAB.exe
    |                                  |
    +-- numberss                       |
    |   [1., 2., 3., 4.]               |
    |                                  |
    |           ?????                  |
    +------------- ? ----------------->|
                                       |
                              Can MATLAB see
                              `numberss`?
```

The important answer is:

> **MATLAB cannot normally reach directly into an independently running
> Python process and retrieve an arbitrary Python object.**

------------------------------------------------------------------------

# 7. Why Can't MATLAB Simply See the Python Object?

The two applications are separate operating-system processes:

``` text
python.exe memory                 MATLAB.exe memory

numberss
   |
   v
[1, 2, 3, 4]       X X X        no `numberss`
```

Each process normally owns its own memory space.

Therefore:

> **Keeping Python alive is necessary if we want ongoing live
> communication with that Python process, but keeping it alive is not
> sufficient.**

There must also be a method of communication between the two processes.

------------------------------------------------------------------------

# 8. Inter-Process Communication (IPC)

Once Python and MATLAB are independent running processes, information
must cross a process boundary.

Possible communication mechanisms include:

``` text
Python.exe                         MATLAB.exe
    |                                  |
    |          communication           |
    +-------------> / <----------------+
```

Examples include:

-   files
-   sockets
-   TCP/IP
-   shared data mechanisms
-   databases
-   REST/API interfaces
-   message passing

The appropriate mechanism depends on the engineering application.

------------------------------------------------------------------------

# 9. From Python Process to ROS 2

This concept creates a useful progression toward ROS 2:

``` text
STEP 1
Python script

run -> calculate -> terminate

        |
        v

STEP 2
Persistent Python

>>> / Jupyter / running program

objects remain alive

        |
        v

STEP 3
Two independent processes

Python.exe                 MATLAB.exe
    |                          |
    |      communication       |
    +----------> / <-----------+

        |
        v

STEP 4
Choose a communication mechanism

file
socket
TCP/IP
API
message passing
...

        |
        v

STEP 5
Distributed robotics software

ROS 2 Node                 ROS 2 Node
Python                     C++ / Python / etc.
    |                          |
    +------ ROS messages ------+
```

A ROS 2 node is normally a **long-running process** because it must
continue to:

-   receive messages,
-   process data,
-   publish messages,
-   communicate with hardware or other nodes.

Understanding Python process lifetime therefore helps prepare students
to understand why ROS 2 nodes behave differently from ordinary one-shot
Python scripts.

------------------------------------------------------------------------

# 10. Key Concepts for Mechanical Engineering Students

Before concentrating on MATLAB--Python syntax, establish the following
concepts:

``` text
Python source file (.py)
        |
        v
Python interpreter
        |
        v
Operating-system process
        |
        v
Process lifetime
        |
        v
Object / memory lifetime
        |
        v
Independent processes
        |
        v
Inter-process communication
```

The central idea is:

> **A source file is not a running program.**

and:

> **A Python object exists in the memory of a running Python process.**

and finally:

> **Two independent processes require a communication mechanism to
> exchange information.**

------------------------------------------------------------------------

## Suggested Next Experiment

The next MATLAB--Python experiment can therefore begin with:

1. Start Python independently from PowerShell or VS Code.
2. Create `numberss` in that Python process.
3. Keep the Python process alive.
4. Start MATLAB independently.
5. Verify that MATLAB cannot simply access `numberss` by name.
6. Introduce one explicit communication mechanism to transfer the data.

This separates two questions that are often accidentally mixed together:

**Question A --- Is Python still running and is the object still
alive?**

**Question B --- If it is alive, how can another process communicate
with it?**

That distinction is fundamental to later MATLAB, ROS 2, embedded, and
distributed-system development.

## Python and MATALB in same computer

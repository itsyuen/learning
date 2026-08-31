# Python Filesystem Basics for MATLAB, PowerShell, Bash, and ROS 2

## Why this matters

When working with MATLAB, Python, Jupyter, VS Code, and eventually ROS
2, one simple question becomes very important:

> **What is my current working directory?**

A program that reads or writes a relative filename normally interprets
that filename relative to its **current working directory**.

For example:

``` python
with open("robot_log.txt", "w") as f:
    f.write(log_text)
```

`"robot_log.txt"` does **not necessarily mean** "put the file beside the
Jupyter notebook." It means "write the file in the current working
directory."

This is why checking the working directory is a useful first debugging
step.

------------------------------------------------------------------------

## 1. The `pwd` concept across environments

The command names differ slightly, but the underlying idea is the same.

  ---------------------------------------------------------------------------------------
  Task                Bash / Linux   PowerShell     MATLAB         Python
  ------------------- -------------- -------------- -------------- ----------------------
  Show current        `pwd`          `pwd`          `pwd`          `os.getcwd()` or
  working directory                                                `Path.cwd()`

  List                `ls`           `ls` or `dir`  `dir`          `os.listdir()`
  files/directories                                                

  Change directory    `cd folder`    `cd folder`    `cd folder`    `os.chdir("folder")`

  Current path        `$PWD`         `$PWD`         `pwd` result   `Path.cwd()`
  object/value        conceptually                                 
  ---------------------------------------------------------------------------------------

The important concept is therefore more universal than the exact syntax:

``` text
Where am I?
    ↓
What is my current working directory?
    ↓
Where will a relative filename be read from or written to?
```

------------------------------------------------------------------------

## 2. Python's `os` library

Python's built-in `os` module provides an interface to
operating-system-related functions.

``` python
import os
```

### Find the current working directory

``` python
print(os.getcwd())
```

`getcwd()` means:

> **get current working directory**

Example output on Windows:

``` text
C:\Users\username\GitHub\learning\matlab_python
```

### List files in the current directory

``` python
print(os.listdir())
```

This is conceptually similar to:

``` bash
ls
```

or MATLAB:

``` matlab
dir
```

### Check whether a file exists

``` python
print(os.path.exists("robot_log.txt"))
```

This returns:

``` text
True
```

or:

``` text
False
```

### Find the absolute path of a file

``` python
print(os.path.abspath("robot_log.txt"))
```

A relative filename such as:

``` text
robot_log.txt
```

may therefore resolve to something like:

``` text
C:\Users\username\GitHub\learning\matlab_python\robot_log.txt
```

------------------------------------------------------------------------

## 3. Relative paths versus absolute paths

A **relative path** describes a location relative to the current working
directory.

``` python
"robot_log.txt"
```

or:

``` python
"data/robot_log.txt"
```

An **absolute path** specifies the complete location:

``` text
C:\Users\username\GitHub\learning\matlab_python\data\robot_log.txt
```

Therefore:

``` python
open("robot_log.txt", "w")
```

depends on the current working directory.

This is one reason why checking:

``` python
os.getcwd()
```

can be very useful when a program appears to have "lost" a file.

------------------------------------------------------------------------

## 4. Modern Python: `pathlib`

Modern Python also provides the `pathlib` library.

``` python
from pathlib import Path
```

Get the current directory:

``` python
here = Path.cwd()

print(here)
print(type(here))
```

An important distinction is that `here` is **not simply a string**. It
is a `Path` object.

On Windows it may be represented by a `WindowsPath` object.

------------------------------------------------------------------------

## 5. Why does `Path` use `/`?

This expression may initially look like unusual string syntax:

``` python
here / "data" / "robot_log.txt"
```

But `/` is **not being used on ordinary strings**.

The `Path` class defines the `/` operator to join filesystem path
components.

``` python
from pathlib import Path

here = Path.cwd()

file = here / "data" / "robot_log.txt"

print(file)
```

Conceptually:

``` text
here
  │
  └── data
       │
       └── robot_log.txt
```

On Windows, Python can represent the resulting path appropriately:

``` text
C:\Users\username\GitHub\learning\matlab_python\data\robot_log.txt
```

This helps make Python code more portable between Windows and Linux.

------------------------------------------------------------------------

## 6. MATLAB `fullfile()` comparison

For MATLAB users, the closest analogy is `fullfile()`.

### MATLAB

``` matlab
file = fullfile("data", "robot_log.txt");
```

### Python with `pathlib`

``` python
file = Path("data") / "robot_log.txt"
```

These express essentially the same intention:

> Build a filesystem path from individual directory and filename
> components.

This is better than manually constructing operating-system-specific path
strings.

------------------------------------------------------------------------

## 7. A `Path` is an object

Because `Path` represents a filesystem path as an object, it provides
useful properties and methods.

``` python
file = Path("data") / "robot_log.txt"

print(file.name)
print(file.suffix)
print(file.parent)
print(file.exists())
print(file.resolve())
```

Typical meanings:

  Expression         Meaning
  ------------------ -----------------------------------
  `file.name`        filename, e.g. `robot_log.txt`
  `file.suffix`      extension, e.g. `.txt`
  `file.parent`      parent directory
  `file.exists()`    whether the path currently exists
  `file.resolve()`   resolved absolute path

This is an early example of an important Python idea:

> Data such as a filesystem path can be represented as an **object with
> useful behavior**, rather than merely as a string.

------------------------------------------------------------------------

## 8. A useful Jupyter diagnostic cell

When using Jupyter notebooks in VS Code, it is useful to know both
**which Python interpreter is running** and **where it is running**.

``` python
import sys
import os

print("Python interpreter:")
print(sys.executable)

print("\nCurrent working directory:")
print(os.getcwd())
```

This is particularly helpful when debugging a wrong **Jupyter kernel
selection**.

Opening an `.ipynb` file in VS Code does not by itself guarantee that
the intended Python environment is executing the notebook.

------------------------------------------------------------------------

## 9. Why this becomes important in ROS 2

A ROS 2 workspace commonly contains directories such as:

``` text
workspace/
├── src/
├── build/
├── install/
└── log/
```

A ROS 2 package may also contain:

``` text
my_robot/
├── package.xml
├── setup.py
├── config/
├── launch/
└── my_robot/
    └── controller.py
```

As projects grow, engineers repeatedly need to understand:

-   Where is the program currently running?
-   Is this path relative or absolute?
-   Where is a configuration or data file?
-   Where will a log file be written?
-   How can paths remain usable when moving between Windows and Linux?

These questions connect basic Python file I/O directly to later ROS 2
development.

------------------------------------------------------------------------

## Key idea

Do not memorize `os` and `pathlib` as collections of unrelated commands.

Remember the filesystem questions first:

``` text
Where am I?                 → current working directory
What files are here?        → directory listing
Where is this file?         → relative / absolute path
Does this file exist?       → existence check
How do I build a path?      → pathlib.Path
```

For MATLAB and control-engineering students, a useful progression is:

``` text
pwd concept
    ↓
current working directory
    ↓
relative vs. absolute paths
    ↓
os
    ↓
pathlib
    ↓
file I/O
    ↓
ROS 2 workspace and package structure
```

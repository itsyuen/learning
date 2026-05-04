# practice flow control of for/while loops, if/else statements, and break/continue statements

a, b = 0, 1     # multiple assignement
while a < 10:   # while loop <, >, == , <=, >=, and !=
    print(a)    # indent body
    a, b = b, a+b   # no need for end

## iterate through packages
packages = ["pkg_msgs", "pkg_driver", "pkg_control"]

for pkg in packages:
    print("Building", pkg)  # used a "pkg" index

## success/failure if statements

result = True

if result:
    print("Build passed")
else:
    print("Fix errors")

## waiting/ polling loops (while)

ready  = False
count = 0

while not ready and count < 5:
    print("checking...")
    count += 1

## Exericses

### Ex1. build selected packages

pkgs = ["msgs", "driver", "planner"]

for p in pkgs:
    print(f"colcon build --packages-select {p}")    # f inside print()

### Ex2. skip broken package
pkgs = ["msgs", "broken_pkg", "planner"]

for p in pkgs:
    if p == "broken_pkg":
        continue
    print("Building", p)

### Ex3. stop if critical failure
errors = 0

for i in range(5):
    if i == 3:
        errors += 1

if errors > 0:
    print("Do not deploy")
else:
    print("Safe to continue")

### Ex4. retry build until success

attempt = 0
success = False

while attempt < 3 and not success:
    print(f"Attempt {attempt+1}")

    if attempt == 2:
        success = True

    attempt +=1

if success:
    print("Build succeed")
else:
    print("Build failed")

### Ex5.



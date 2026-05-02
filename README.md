# learning repo's README.md
2026-05-01 *Peter Chang* update

This repo's purpose is meant to be the basis for teaching and research publication
where most of the material will become either `teaching` repo's `module` or
`desktop-tutorial`'s `project`, including and most importantly towards `paper`.

## Objective

The old Matlab scripts are now moved into different directories, taylored
towards the following:
- robotics
    - adaptive control
    - macnum wheel vehicle dynamics control
- torque control
    - human intention
    - assitive control
    - distrubance estimation
- system identification
    - Sindy application on J/I moment of inertia online estimation
    - Extended Kalman Filter friction ID
- Control derivation
    - full vehicle on slope dynamics slide prevention

### Topics arrangement

Currently likely to move paper towards `desktop-tutorial` once all the simple 
fundation is ready here on the `learning` objective, and copy the scripts/block
into a working `paper01` directory inside `publication_ws`, and reuse all results
for more or less **editing** rather then writing....

*Writing* is done here in the `learning` repo and for two seperate audiences:
1. students, either graduate or undergaraduate for teaching propose
2. peers, editors and reviewers for publication propose

## python and c/c++ as well as other learning objectives

1. as the directory names suggests, all the control idea is applicable in the robotics realm
2. later c/c++ and python codes are used for ROS2/ROS integration, as will be moved to `projects` inside `desktop-tutorial`
3. all the needed code snippets are first derived here, later transfer to `teaching` as my class `modules`, expecailly like filters and all

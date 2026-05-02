# learning repo's README.md
2026-05-01 *Peter Chang* update

Current learning directory for both MATLAB/cpp/python and many other learning opertunities for me. This repo will be kind of personal growth activity traces.

- added /matlab for concentrating matlab/simulink codes
- added /python for concentrating on python practices
- added /src for .m file sources (now mainly student jack's adaptive code)
- added /scripts and paper01.mlx, for draft on script file, will move paper targeted and project targeted to desktop-tutorial

## Objective of the `learning` repo
 
This `learning` repo will be used as staging place for later `teaching` and `desktop-tutorial` repo
- `teaching` will handel `module` and `course`, and see that many `learning` material can be copied and moved to become specific `modules`
- `desktop` will be like a `project` based workspace, although it is like a `tutorial` for everything that is starting there. Will move all the research `learning` part to be compiled and archived into publishable papers and projects that it's code is sharable to the world!!!
- make this `learning` a starting point of everyday work!!!!


## past data 
- Now syncing through HackMD.io, using user tsyuen@gmail.com.
- This is meant to be for `teaching` and `desktop-tutorial` as hackmd.io will inherit all the `README.md` that is embedded in the `teaching` and `desktop-tutorial` directories

## current directory structure
```text
learning/
├── README.md
├── matlab/
|     ├── scripts/
|     └── sources/
├── python/
├── figures/
└── notes/
```

### old archive that is in the past data
All detailed management is documented here, along with the most important "leaning to survive lab", using the brand new toolchian:

- These are the toolchains that Peter is going to be Alsways Be Learning.... ABL (`learning`) to publish (`desktop`) to project (`-tutorial`) to the world (`teaching`) repo usage
1. hackmd + github integration. Learning to use `hackmd.io` to import from github as an integrated .md file, updated **regularily manually**.
2. matlab/simulink + ROS toolbox usage. Learning to run Robotics systems inside `MATLAB/simulink` as a fast **controller test and verification**, as well as **robotic system** visualization
3. ROS2 turtle sim tutorial for node, message, topic, action, requset and more.
4. Embedded coder inside matlab/simulink + c/c++ opp
5. speed goat simulink with simscape comparison
6. CubeIDE/Arduino using Embedded RTOS with interrupts
7. Ubuntu/Linux with ROS2 using c++ cmake for robotics projects later used more inside `desktop-tutorial`
8. NAS organization with cloud sync for collaboration learning...
9. Git usage learning....
10. Markdown standard/simple usage for direct teaching/learning...

- objective that is done

- [x] hackmd + github integration
- [x] added push/pull request and also fast git commands.. inside bash
- [ ] currently add all figures here on GitHub.
- [ ] todo
- [x] done

---

## test area
This file is now maintained directly inside `learning` repo, and git push-pull on the "learning repo" at github, then finally pulled to hackmad.io for showing to myself!!!.

I am trying to link another hackmd.io file, that will be the reposotories that is the NAS directories and nameing convention for my personal databse usage!!!
$$
\dot{x}(t) = \mathbb{A} x(t) + \mathbb{B} u(t) \\
y(t) = \mathbb{C} x(t) + \mathbb{D} u(t) 
$$

[NAS naming convention][NAS naming convention](https://github.com/itsyuen/learning/blob/master/notes/sscl_nas_to_cloud_sync_blueprint_v_0.md)

[![hackmd-github-sync-badge](https://hackmd.io/TlpUVPNyRrKUY5LOcNEJ0Q/badge)](https://hackmd.io/TlpUVPNyRrKUY5LOcNEJ0Q)


# Learning matlab's repo

*Peter Chang*

This repo's purpose is meant to be the basis for teaching and research publication
where most of the material will become either `teaching` repo's `module` or
`desktop-tutorial`'s `project`, including and most importantly towards `paper`.

## Objective

Matlab script here are now slowly evolving into different directories, taylored
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
    

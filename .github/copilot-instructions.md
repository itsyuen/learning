# Copilot instructions for the "learning" repository

## Purpose
- This repo is a teaching/research workspace centered on MATLAB/Simulink projects for robotics and control, with supporting Python snippets and ROS-related notes.

Build / test / lint commands
- MATLAB unit test runner (project-local): Open MATLAB project at repo root and run matlab_toolbox/robotics/RoboticManipulators/SoftwareTests/RunAllTests.m
  - Interactive: Open the project in MATLAB and run RunAllTests(true) to open HTML report.
  - CLI (MATLAB installed): matlab -batch "RunAllTests(true)"
- Run a single test interactively: in MATLAB use runtests('SmokeTests') or runtests('FunctionTests') or pass a filename/class: runtests('path/to/SpecificTest.m')
- Test reports: RunAllTests writes HTML under <projectRoot>/public/<MATLAB-release>/index.html and a TestResults_<release>.txt
- No repository-level package build, Python test, or CI workflows detected. No npm/pyproject/Makefile present.

## High-level architecture (big picture)
- Top-level is an educational collection (learning) of topic folders: matlab_toolbox (MATLAB/Simulink toolboxes and tests), adaptive, filters, robotics, ros_codegen, python, notes.
- matlab_toolbox/robotics/RoboticManipulators is a self-contained MATLAB project with a SoftwareTests suite (SmokeTests, FunctionTests, SolnSmokeTests) and a test runner that emits HTML reports.
- python/ contains short, educational Python snippets (basics, oop, ros). ROS2 integration is planned (colcon/CMake interop noted in READMEs).
- Simulink models (.slx) and live scripts (.mlx) are used as canonical examples; many notebook-style live scripts are used for teaching rather than production libraries.

## Key conventions and patterns
- MATLAB-first workflow: expect to run and validate code inside MATLAB. Tests use matlab.unittest.* and are invoked via RunAllTests.m.
- Live scripts (.mlx) and Simulink models (.slx) are primary artefacts for examples and exercises; prefer editing/viewing in MATLAB/Simulink rather than plain text editors.
- Test artifacts and reports are written to project/public/<MATLAB-release> (the RunAllTests runner creates and clears this directory before writing reports).
- CONTRIBUTING.md under matlab_toolbox provides contribution expectations (CLA, reporting security issues, preferred example formats).
- Git ignores cover common Python/MATLAB build/temp files (see .gitignore for details such as slprj/, *.asv, *.autosave).

Files and configuration to check when extending Copilot assistance
- matlab_toolbox/robotics/RoboticManipulators/SoftwareTests/RunAllTests.m (test runner)
- matlab_toolbox/robotics/RoboticManipulators/SoftwareTests/* (test classes)
- python/ README and subdirectories (for Python/ROS snippets)

When requesting Copilot actions in this repo (recommendations for prompts)
- Be explicit that MATLAB is the primary runtime and indicate whether MATLAB GUI is available or only CLI/batch.
- For test-related tasks, name the specific MATLAB test class or the RunAllTests entry point.
- When asking to refactor or modify examples, indicate whether the target is a live script (.mlx) or a plain .m file; changes to .mlx may be lossy if handled outside MATLAB.

Other AI assistant/config files discovered
- No CLAUDE.md, AGENTS.md, or other AI assistant rules files were found in the repository root. CONTRIBUTING.md exists under matlab_toolbox and is relevant to contributors.

If anything above should be more detailed (example commands, additional directories, or CI setup snippets), tell me which area to expand.

## Owner Intent
- This repository is maintained by Peter Chang, a mechanical engineering professor using modern toolchains to bridge classical engineering education with software-defined systems.
- Priorities: teach clearly, build reusable examples, and integrate MATLAB + Python + C++ + ROS2 workflows over time.

## Preferred Assistance Style
- Favor educational clarity over cleverness.
- Explain concepts for engineering students with moderate programming background.
- Use step-by-step examples.
- Prefer readable code with comments.
- When multiple options exist, recommend practical industry-relevant solutions.

Future Direction
- Gradual migration from MATLAB-only examples toward Python, C++, ROS2, and embedded workflows.
- Future folders may include CMake, STM32, code generation, and robotics deployment pipelines.

Language Guidance
- English is primary for code/comments.
- Traditional Chinese may be used for teaching notes and explanations.
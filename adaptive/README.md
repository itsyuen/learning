# Learning adaptive's repo
*Peter Chang*

## objective
This repos is dedicated to the paper writing on adaptive jacobianless controll verification.

## current directory
```text
adaptive/
├── figures/
├── sources/
│   ├── directories of source files/
│   ├── torque_cal/
│   ├── word document files.docx
│   ├── thesis.pdf
│   └── FromJack.md
├── references/ 
├── working_20251001_publish.mlx
└── README.md
```

## active steps
0. modeling RR planar manipulator dynamics 
1. make a simulnik model that changes I (moment of inertia) at certain time
2. pre-design work space movement (position/velocity.... this gives accelleration)
3. adaptive controller application to verify adaptiveness
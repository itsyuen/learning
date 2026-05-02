# Learning adaptive's repo
*Peter Chang*

## objective
This repos is dedicated to the paper writing on adaptive jacobianless controll verification.

## current directory
```text
adaptive/
├── sources/
│   ├── FAT1/
│   ├── torque_cal/
│   ├── Computed Torque Method.docx
│   ├── FAT_based_Adaptive_1.docx
│   └── FromJack.md
├── paper1.mlx
├── working_20251001_publish.mlx
└── README.md
```

## active steps
0. modeling RR planar manipulator dynamics 
1. make a simulnik model that changes I (moment of inertia) at certain time
2. pre-design work space movement (position/velocity.... this gives accelleration)
3. adaptive controller application to verify adaptiveness
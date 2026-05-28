# TUIO6

# Nonlinear System Observability Toolbox

This MATLAB toolbox computes the **observability codistribution** for a class of nonlinear dynamical systems affected by unknown inputs.

## 📌 Problem Description

The considered system class is given by

\dot{x} = g^0(x, t, u(t)) + \sum_{j=1}^{m_w} g^j(x, t, u(t)) w_j

where:
- `x` is the state vector,
- `t` is time,
- `u(t)` denotes **known (prescribed) control inputs (input trajectories)**,
- `w_j` are **unknown inputs** (not measured and not available to the observer),
- `g^0(x, t, u(t))` and `g^j(x, t, u(t))` are analytic vector fields.

In this framework, control inputs are assumed to be known a priori and enter the system through prescribed trajectories. They may influence both the drift term and the unknown-input vector fields.

Observability is defined with respect to these fixed input signals, while unknown inputs remain arbitrary external disturbances.


## 🚀 Features

- Computes the **observability codistribution** in the presence of unknown inputs.
- Designed for symbolic analysis in control theory and nonlinear observability.
- Supports symbolic expressions in MATLAB.

## 🔧 Requirements

- MATLAB (R2020 or later recommended)
- Symbolic Math Toolbox

## 📂 Structure

- `initialize_system.m`: Defines the system dynamics and returns the required symbolic variables
- `main.m`: Runs the observability analysis using the initialized system
- `functions/`: Core functions for codistribution computation

## 📖 How to Use

1. Clone or download the repository.
2. Open `initialize_system.m` and define your system dynamics.
3. Run `main.m` to compute the observability codistribution.

## 🧑‍💻 Author

This toolbox was developed by Agostino Martinelli, 2025.

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.



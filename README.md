# TUIO6

# Nonlinear System Observability Toolbox

This MATLAB toolbox computes the **observability codistribution** of a class of nonlinear dynamical systems solely driven by unknown inputs.

## 📌 Problem Description

The system dynamics are assumed to be of the following form:

\dot{x} = g^0(x, t) + \sum_{j=1}^{m_w} g^j(x, t) w_j

where:
- `x` is the system state vector,
- `t` is time,
- `wⱼ` are **unknown inputs**,
- `g^0(x, t)` and `g^j(x, t)` are analytic vector fields.

This structure covers a wide range of real-world systems where the inputs cannot be measured (and controlled).

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



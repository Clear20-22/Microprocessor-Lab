# 🖥️ Microprocessor Lab - x86-64 Assembly Programming

[![Assembly](https://img.shields.io/badge/Assembly-x86--64-blue.svg)](https://www.nasm.us/)
[![NASM](https://img.shields.io/badge/NASM-2.14+-green.svg)](https://www.nasm.us/)
[![Educational](https://img.shields.io/badge/Purpose-Educational-yellow.svg)](#)

A comprehensive collection of x86-64 assembly language programs developed for microprocessor laboratory coursework. This repository contains various assembly programs demonstrating fundamental concepts, algorithms, and data structures implementation in low-level programming.

## 📚 Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [How to Run](#how-to-run)
- [Lab Descriptions](#lab-descriptions)
- [Programs Included](#programs-included)
- [Contributing](#contributing)
- [Resources](#resources)
- [Troubleshooting](#troubleshooting)
- [License](#license)
- [Author](#author)
- [Acknowledgments](#acknowledgments)

## 🎯 Overview

This repository serves as a complete resource for learning and practicing x86-64 assembly language programming. It includes:

- **Laboratory Exercises**: Organized lab assignments covering progressive difficulty levels
- **Practice Programs**: Additional exercises for skill development
- **Algorithm Implementations**: Common algorithms implemented in assembly
- **Exam Solutions**: Sample exam problems and solutions

All programs are written in **NASM (Netwide Assembler)** syntax for x86-64 architecture and compiled on Linux systems.

## 📁 Repository Structure

```
Microprocessor-Lab/
├── lab1/                    # Introduction to Assembly - Hello World & Basic Operations
├── lab2/                    # Input/Output and Basic Arithmetic
├── lab3/                    # Control Flow & Algorithms (GCD, etc.)
├── lab4/                    # Advanced Operations (Number Reversal, etc.)
├── lab5/                    # Complex Programs & Matrix Operations
├── Lab Exam/                # Exam problems (Min/Max, Palindrome)
├── Practice/                # Practice exercises (larger programs)
├── practice/                # Additional practice files (smaller exercises)
├── all/                     # Complete collection of common algorithms
├── rough/                   # Development/testing files
├── sojib_23_min_max.asm    # Min/Max implementation
└── README.md               # This file
```

> **Note:** The repository contains both `Practice/` and `practice/` directories due to case-sensitivity in the original file structure. Both contain practice exercises.

## 🔧 Prerequisites

To compile and run these assembly programs, you need:

### Required Software
- **NASM** (Netwide Assembler) - v2.14 or higher
- **GCC** (GNU Compiler Collection) - for linking
- **Linux** or **WSL (Windows Subsystem for Linux)**
- **Make** (optional, for automation)

### Installation on Ubuntu/Debian:
```bash
sudo apt update
sudo apt install nasm gcc build-essential
```

### Installation on Fedora/RHEL:
```bash
sudo dnf install nasm gcc make
```

### Installation on macOS:
```bash
brew install nasm gcc
```

## 🚀 Installation & Setup

1. **Clone the repository:**
```bash
git clone https://github.com/Clear20-22/Microprocessor-Lab.git
cd Microprocessor-Lab
```

2. **Verify NASM installation:**
```bash
nasm -v
```

3. **Verify GCC installation:**
```bash
gcc --version
```

## ▶️ How to Run

Assembly programs follow a three-step compilation process:

### Basic Compilation Steps

**Step 1: Assemble** (`.asm` → `.o`)
```bash
nasm -f elf64 program.asm -o program.o
```

**Step 2: Link** (`.o` → executable)
```bash
gcc -no-pie program.o -o program
```

**Step 3: Execute**
```bash
./program
```

### Quick Example

To run the hello world program from lab1:
```bash
cd lab1
nasm -f elf64 hello.asm -o hello.o
gcc -no-pie hello.o -o hello
./hello
```

### One-Line Compilation
```bash
nasm -f elf64 program.asm -o program.o && gcc -no-pie program.o -o program && ./program
```

### Debugging with GDB
```bash
nasm -f elf64 -g -F dwarf program.asm -o program.o
gcc -no-pie -g program.o -o program
gdb ./program
```

## 🧪 Lab Descriptions

### Lab 1: Introduction to Assembly
- **Focus**: Basic program structure, data types, registers
- **Programs**: Hello World, basic arithmetic operations
- **Key Concepts**: Data section, text section, system calls

### Lab 2: Input/Output Operations
- **Focus**: User input, formatted output using `scanf` and `printf`
- **Programs**: Addition, subtraction, multiplication with user input
- **Key Concepts**: External C library functions, stack management

### Lab 3: Control Flow & Algorithms
- **Focus**: Conditional statements, loops, algorithm implementation
- **Programs**: GCD calculation, iterative algorithms
- **Key Concepts**: Labels, jumps, comparisons, division

### Lab 4: Advanced Operations
- **Focus**: Complex number operations, sign handling
- **Programs**: Number reversal, negative number handling
- **Key Concepts**: BSS section, arithmetic operations, conditional logic

### Lab 5: Complex Programs
- **Focus**: Arrays, matrices, advanced data structures
- **Programs**: Matrix operations, bitwise AND on matrices
- **Key Concepts**: Memory allocation, 2D arrays, nested loops

## 📋 Programs Included

### In `/all` directory - Complete Algorithm Library:

| Program | Description |
|---------|-------------|
| `add.asm` | Addition of two numbers |
| `sub.asm` | Subtraction of two numbers |
| `mul.asm` | Multiplication (unsigned) |
| `imul.asm` | Signed multiplication |
| `div.asm` | Division operation |
| `div_pro.asm` | Advanced division |
| `factorial.asm` | Factorial calculation |
| `n_fibonacci.asm` | N Fibonacci numbers |
| `nth_fibonacci.asm` | Nth Fibonacci number |
| `check_prime.asm` | Prime number checker |
| `divisor_finding.asm` | Find all divisors |
| `max_among_3.asm` | Maximum of three numbers |
| `reverse_int.asm` | Reverse an integer |
| `reverse_string.asm` | Reverse a string |
| `multiplication_table.asm` | Generate multiplication table |

### Lab Exam Problems:
- **Min/Max Finding**: Find minimum and maximum in an array
- **Palindrome Checker**: Check if a number/string is palindrome

## 🤝 Contributing

Contributions are welcome! If you'd like to add more programs or improve existing ones:

1. Fork the repository
2. Create a new branch (`git checkout -b feature/new-program`)
3. Add your assembly program with proper comments
4. Test your program thoroughly
5. Commit your changes (`git commit -m 'Add: new program description'`)
6. Push to the branch (`git push origin feature/new-program`)
7. Open a Pull Request

### Coding Guidelines:
- Use meaningful variable names
- Add comments explaining complex logic
- Follow NASM syntax conventions
- Test programs on x86-64 Linux systems
- Include a brief description at the top of each file

## 📖 Resources

### Learning Assembly:
- [NASM Documentation](https://www.nasm.us/docs.php)
- [x86-64 Assembly Guide](https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf)
- [Intel Architecture Manual](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)
- [System V ABI Reference](https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf)

### Online Tools:
- [Online Assembler](https://www.tutorialspoint.com/compile_assembly_online.php)
- [Compiler Explorer](https://godbolt.org/)

### Tutorials:
- [Assembly Language Tutorial (Tutorialspoint)](https://www.tutorialspoint.com/assembly_programming/)
- [x86-64 Assembly Programming](https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html)

## 🐛 Troubleshooting

### Common Issues:

**Issue**: `undefined reference to printf`
- **Solution**: Make sure to link with gcc: `gcc -no-pie program.o -o program`

**Issue**: Segmentation fault
- **Solution**: Check stack alignment and register usage. Use `gdb` for debugging.

**Issue**: NASM not found
- **Solution**: Install NASM: `sudo apt install nasm`

**Issue**: Wrong architecture
- **Solution**: Ensure you're using `-f elf64` for 64-bit systems

## 📄 License

This repository is available for educational purposes. Feel free to use and modify the code for learning.

## 👨‍💻 Author

**Sojib** - Microprocessor Lab Coursework

## ⭐ Acknowledgments

- Thanks to all contributors and students who have helped improve this repository
- Special thanks to instructors for guidance and support
- Inspired by various assembly programming resources and textbooks

---

**Happy Coding! 🚀**

*If you find this repository helpful, please consider giving it a star ⭐*
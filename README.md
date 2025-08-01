# ⚡ Basic Verilog Projects

This repository contains a collection of **basic Verilog programs** developed to understand digital design concepts and simulation workflows.  
It demonstrates the implementation of fundamental circuits and testbenches for hands-on learning in Hardware Description Language (HDL).  

---

## 📌 Features

- 📐 Implementation of fundamental digital logic circuits  
- 🧪 Testbenches for functional verification  
- ⏱️ Timing simulation using Icarus Verilog  
- 📊 Waveform visualization with GTKWave  

---

## 🛠️ Tech Stack

- **Language:** Verilog HDL  
- **Simulator:** [Icarus Verilog](http://iverilog.icarus.com/)  
- **Waveform Viewer:** [GTKWave](http://gtkwave.sourceforge.net/)  
- **OS:** Cross-platform (Linux, Windows, macOS with Icarus Verilog & GTKWave installed)

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/AnupriyaBiswas/Basic-Verilog.git
cd Basic-Verilog
````

### 2️⃣ Install Required Tools

* **Ubuntu / WSL**

  ```bash
  sudo apt update
  sudo apt install iverilog gtkwave
  ```

* **Windows**

  * Install [Icarus Verilog](https://bleyer.org/icarus/)
  * Install [GTKWave](http://gtkwave.sourceforge.net/)

---

## ▶️ Running a Simulation

Assume your design file is `design.v` and testbench is `testbench.v`.

### Step 1: Compile

```bash
iverilog -o output.out design.v testbench.v
```

### Step 2: Run Simulation

```bash
vvp output.out
```

This will generate a `dump.vcd` file if `$dumpfile` and `$dumpvars` are included in your testbench.

### Step 3: View Waveforms in GTKWave

```bash
gtkwave dump.vcd
```

---

## 📊 Example Testbench Snippet

```verilog
module testbench;
  reg a, b;
  wire sum, carry;

  // Instantiate the design
  half_adder ha(a, b, sum, carry);

  initial begin
    $dumpfile("dump.vcd"); // For GTKWave
    $dumpvars(0, testbench);

    // Apply test inputs
    a = 0; b = 0;
    #10 a = 0; b = 1;
    #10 a = 1; b = 0;
    #10 a = 1; b = 1;
    #10 $finish;
  end
endmodule
```

---

## 📌 Contents

* **Combinational Circuits**

  * Half Adder
  * Full Adder
  * Multiplexers / Demultiplexers
  * Encoders / Decoders

* **Sequential Circuits**

  * Flip-Flops (D, JK, T)
  * Counters
  * Registers

---

## 📌 Future Work

* Add more complex sequential circuits
* Include parameterized modules
* Provide synthesis-ready code examples

---

## 🙌 Acknowledgements

This repository was created as part of the **Hardware Lab Curriculum at NIT Rourkela**,
focusing on learning Verilog for digital design and simulation.

---

## 📜 Note

Feel free to fork and contribute!

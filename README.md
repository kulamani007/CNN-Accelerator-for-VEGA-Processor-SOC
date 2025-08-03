
# 🔥 Vega SoC-Based CNN Accelerator on FPGA

A hardware-accelerated image-processing project built with Verilog, integrated with the **CDAC Vega RISC-V SoC**, and simulated using **Vivado 2025.1**. This project showcases how multiple AXI4-Lite slave peripherals (CNN, Kalman Filter, Motor Controller, and RLE Encoder) can be interconnected and managed through a custom SoC integration.

---

## 🧠 Project Overview

This project performs a **3x3 convolution** operation on a grayscale image patch using a **Convolutional Neural Network (CNN) logic**, and processes the result through optional modules:
- **Kalman Filter** for noise smoothing
- **Motor Controller** to control hardware based on CNN output
- **RLE Encoder** to compress data

The system is integrated into a **RISC-V based Vega SoC** via a **simplified AXI4-Lite interface**, replacing the original dummy accelerator IP with this custom multi-peripheral top module.

---

## 🎯 Objectives

- ✅ Design hardware IPs for CNN, Kalman, Motor, RLE
- ✅ Integrate with Vega SoC using AXI-Lite interface
- ✅ Simulate and synthesize the complete system
- ✅ Generate waveforms to verify functionality
- ✅ Demonstrate real-world applicability on FPGA

---

## 🔗 Architecture & File Connectivity

```
                      [VEGA SoC]
                        |
                ---------------------
                |                   |
          [vega_wrapper.v]    (AXI-Lite)
                |
          [top_module.v]
      ┌────────┼────────┬────────┬────────┐
      ↓        ↓        ↓        ↓        ↓
 [cnn_axi.v] [kalman] [motor]  [rle]   → GPIO
```

### 📌 Why modular?
Each module is independent and can be reused, replaced, or extended — ensuring scalability in SoC design.

---

## 📂 File Overview

| 📁 File/Folder        | 📌 Purpose |
|----------------------|------------|
| `src/top_module.v`   | Integrates CNN, Kalman, Motor, RLE modules |
| `src/cnn_axi.v`      | Custom CNN IP that performs 3x3 convolution |
| `src/kalman_axi.v`   | Applies 1D Kalman filtering on input |
| `src/motor_axi.v`    | Controls motor direction and PWM signal |
| `src/rle_axi.v`      | Encodes data stream using RLE |
| `src/vega_wrapper.v` | Wraps `top_module` and connects to Vega AXI |
| `testbench/`         | Testbenches for verifying functionality |
| `synthesis/`         | Vivado project and report files |
| `simulation/`        | VCD and waveform images |
| `constraints/`       | Genesys 2 pin mapping `.xdc` file |
| `docs/`              | Final presentation, architecture, and notes |

---

## ⚙️ Module Descriptions

### 1️⃣ `cnn_axi.v` — **Convolutional Neural Network IP**
- Accepts 3x3 grayscale image patch (9 values) + 3x3 kernel (9 weights)
- Performs **dot product convolution**
- Result sent to GPIO for monitoring or further processing

🔧 **Example**:
```
Image:  [1 2 3]
        [4 5 6]     Kernel: [1 0 0]
        [7 8 9]              [0 1 0]
                            [0 0 1]
Result: 1*1 + 5*1 + 9*1 = 15
```

### 2️⃣ `kalman_axi.v` — **Kalman Filter IP**
- Receives noisy measurement
- Updates internal state estimate `x`
- Smooths out noise using **Q16.16 fixed-point arithmetic**

📌 Used for scenarios where CNN output may vary or jitter (e.g., object tracking)

### 3️⃣ `motor_axi.v` — **PWM + Direction Control**
- Accepts:
  - 8-bit speed (0–255)
  - 1-bit direction (0 = CW, 1 = CCW)
- Generates:
  - `motor_pwm` signal (PWM duty cycle)
  - `motor_dir` signal (direction)

💡 Can be mapped to physical motors to act on CNN decisions.

### 4️⃣ `rle_axi.v` — **Run-Length Encoder**
- Compresses repeated data in a stream
- Takes 20 bytes of input
- Produces encoded value + count pairs

🧵 Example:
```
Input: AAAABBBCCDD
Output:
  - A → 4
  - B → 3
  - C → 2
  - D → 2
```

---

## 🧩 How the Modules Work Together

1. **Input Image → CNN**
   - Writes image & kernel via AXI
   - Output (e.g., edge intensity) is calculated

2. **CNN Output → Kalman (optional)**
   - Smooths noisy CNN outputs (useful in real-time camera feeds)

3. **CNN/Kalman Output → Motor**
   - Can drive motors depending on classification/detection result

4. **CNN Output → RLE**
   - Useful if output stream is image/video-based and needs compression

5. **Output → GPIO**
   - For hardware verification

---

## 📊 Simulation & Waveform

Include simulation screenshots and results like:

- `cnn_simulation.png`
- `soc_waveform.png`

---

## 🧪 Testbench Overview

The provided unified testbench:
- Initializes all AXI signals
- Writes image/kernel to CNN
- Reads back result and compares
- Tests Kalman estimation
- Tests Motor PWM setting and direction
- Validates RLE encoding (e.g., "AAAABBBCC")

---

## 🧠 Real-World Applications

✅ Could be deployed in:
- **Edge AI devices** — image recognition on FPGA
- **Robotics** — use CNN to detect and drive motor response
- **Signal Processing** — noise filtering with Kalman
- **IoT Devices** — compress sensor data using RLE

---

## 🖥️ Synthesis

- Synthesized using Vivado 2025.1
- Target Board: **Genesys 2 (xc7k325tffg900-2)**
- Bitstream successfully generated
- All I/O mapped via XDC constraints

📄 See full report: [`synthesis_report.pdf`](Synthesys)

---

## 🛠️ Requirements

- Vivado 2025.1
- Genesys 2 Board
- RISC-V Vega SoC integration files

---

## 📄 License

This project is released under the [MIT License](LICENSE).

---

## 💡 Future Work

- Add UART output to Vega
- Use BRAM for larger image patches
- Drive an actual motor based on CNN result
- Implement softmax or pooling inside CNN IP

---

## 🙌 Acknowledgements

- **CDAC Vega Hackathon 2025**
- Genesys 2 FPGA Board
- Vega SoC platform team

---

> 🧠 **NOTE**: This project originally used MicroBlaze for initial testing. Later, the same AXI-Lite protocol made it compatible with Vega RISC-V without significant changes, demonstrating portability of hardware IPs in SoC ecosystems.

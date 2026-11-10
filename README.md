# UART Transmitter and Receiver Using Verilog HDL

## 1. Project Overview

This project implements an 8-bit UART (Universal Asynchronous Receiver Transmitter) communication system using Verilog HDL.

The design consists of an FSM-based transmitter, receiver, baud rate generator, and top-level module.

The transmitter and receiver are connected internally using a loopback architecture to verify successful serial data transmission and reception.

The complete design has been implemented and functionally verified using **Xilinx Vivado Behavioral Simulation**.

## 2. Tools and Technologies

- **Hardware Description Language:** Verilog HDL
- **Design and Simulation Tool:** Xilinx Vivado
- **Simulation Type:** Behavioral Simulation
- **Architecture:** FSM-Based RTL Design
- **Communication Protocol:** UART

## 3. Design Specifications

| Parameter | Configuration |
|---|---|
| System Clock Frequency | 100 MHz |
| TX Baud Rate | Approximately 19,200 bps |
| RX Oversampling | Approximately 16× |
| Data Width | 8 bits |
| Start Bit | 1 |
| Stop Bit | 1 |
| Data Transmission | LSB First |
| Architecture | FSM Based |
| Communication | Internal Loopback |

## 4. UART Architecture

The UART system consists of the following modules:

1. **Baud Rate Generator:** Generates TX and RX enable signals using clock counters.
2. **UART Transmitter:** Converts parallel 8-bit input data into serial data.
3. **UART Receiver:** Receives serial data and converts it into parallel 8-bit output.
4. **UART Top Module:** Integrates the baud rate generator, transmitter, and receiver.
5. **Testbench:** Verifies the complete UART communication system.

### RTL Architecture Diagram(Schematic Diagram)
<img width="1621" height="886" alt="Screenshot 2026-11-10 180250" src="https://github.com/user-attachments/assets/b3d57c13-d0da-4325-9305-3c2944f25168" />

*Figure 1: UART Transmitter and Receiver Architecture*

## 5. UART Frame Format

Each UART frame consists of:

- 1 Start Bit (Logic 0)
- 8 Data Bits (LSB First)
- 1 Stop Bit (Logic 1)

## 6. Project Folder Structure

```text
UART-Transmitter-Receiver/
│
├── Design/
│   ├── baud_rate_generator.v
│   ├── transmitter.v
│   ├── uart_reciever.v
│   └── uart_top.v
│
├── Simulation/
│   └── uart_tb.v
│
├── docs/
│   └── images/
│       ├── uart_architecture.png
│       ├── waveform_overview.png
│       ├── waveform_transmitter.png
│       ├── waveform_receiver.png
│       └── simulation_output.png
│
└── README.md
```

## 7. Simulation and Verification

The complete UART system was verified using a self-checking Verilog testbench in Xilinx Vivado.

Two test cases were performed to verify correct data transmission and reception.

### Test Case Results

| Test Case | Transmitted Data | Received Data | Status |
|---|---|---|---|
| Test 1 | 0x41 | 0x41 | PASS |
| Test 2 | 0x55 | 0x55 | PASS |

### 7.1 Complete Simulation Waveform

<img width="1588" height="885" alt="Screenshot 2026-11-10 175832" src="https://github.com/user-attachments/assets/85aa2237-3464-4ea4-bd2f-31dbc4e3bf62" />


*Figure 2: Complete UART Simulation Waveform*

### 7.2 Transmitter Waveform

<img width="1572" height="822" alt="Screenshot 2026-11-10 175931" src="https://github.com/user-attachments/assets/94acc87d-6308-4625-802a-dda158a4b320" />

*Figure 3: UART Transmitter Signals*

### 7.3 Receiver Waveform
<img width="1610" height="837" alt="Screenshot 2026-11-10 180055" src="https://github.com/user-attachments/assets/d1149855-210b-4ba0-8f68-073e02b05a4b" />

*Figure 4: UART Receiver Signals*

### 7.4 Simulation Output
<img width="1576" height="551" alt="Screenshot 2026-11-10 180439" src="https://github.com/user-attachments/assets/701a72ee-ef08-4335-8643-f63974574757" />


*Figure 5: Vivado Tcl Console Showing Successful Test Results*

### Expected Simulation Output

```text
First byte received = 41
TEST 1 PASSED

Second byte received = 55
TEST 2 PASSED

UART SIMULATION COMPLETED
```

Both test cases successfully demonstrated correct UART data transmission and reception.

## 8. Important Signals

| Signal | Description |
|---|---|
| `clk` | System clock |
| `rst` | Reset signal |
| `data_in` | Parallel input data |
| `wr_en` | Write enable signal |
| `tx_temp` | Serial transmitter output |
| `busy` | Transmitter busy indicator |
| `rdy` | Receiver ready indicator |
| `dout` | Received parallel data |

## 9. How to Run the Project in Vivado

1. Create a new RTL project in Xilinx Vivado.
2. Add the four Verilog design files under Design Sources.
3. Add `uart_tb.v` under Simulation Sources.
4. Set `uart_tb` as the simulation top module.
5. Run Behavioral Simulation.
6. Observe the UART transmission and reception waveforms.
7. Verify the received data in the Tcl Console.

## 10. Key Learning Outcomes

- Understanding UART serial communication protocol.
- FSM-based RTL design and implementation.
- Baud rate generation using clock counters.
- Parallel-to-serial data conversion.
- Serial-to-parallel data conversion.
- Verilog module instantiation and integration.
- Self-checking testbench development.
- Functional verification using Vivado.

## 11. Reference

This project was developed with reference to the following UART Verilog HDL tutorial:

**UART Transmitter and Receiver – Verilog HDL Tutorial**

- YouTube Lecture: [Watch the Reference Video](https://youtu.be/W9AUBDFcYdE)

The lecture was used as a learning reference for understanding UART architecture, baud rate generation, transmitter and receiver FSM implementation, and simulation methodology.


## 12. Project Status

**Completed – Functional Verification Successful**

The UART transmitter and receiver design has been successfully verified through Vivado behavioral simulation using two test cases.

FPGA hardware implementation and physical validation are separate future steps.

---

**If you find this project useful, feel free to star the repository!**

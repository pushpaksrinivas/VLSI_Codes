Absolutely — below is a polished `README.md` you can directly put into your GitHub repository. It is written specifically for a **Traffic Light Controller implemented on the Digilent Nexys A7 using Verilog HDL and Vivado**.

 # 🚦 Traffic Light Controller Using FSM on Nexys A7

 A **Finite State Machine (FSM)-based Traffic Light Controller** designed using **Verilog HDL** and implemented on the **Digilent Nexys A7 FPGA Development Board**.

 The project demonstrates the practical implementation of a synchronous FSM, clock division, timing control, RTL design, simulation, synthesis, implementation, and FPGA hardware testing using **Xilinx Vivado**.

---

 ## 📌 Project Overview

 Traffic lights are a classic example of a **Finite State Machine (FSM)** because the controller moves through a predefined sequence of states based on timing conditions.

 This project implements a two-road traffic intersection:

 - **North-South (NS) road**
- **East-West (EW) road**

 At any given time, one road is allowed to proceed while the other road remains stopped.

 The controller cycles continuously through four states:

```
        ┌──────────────────────────┐
        │                          │
        ▼                          │
┌─────────────────┐                │
│ S0: NS GREEN    │                │
│     EW RED      │                │
└────────┬────────┘                │
         │ Timer Done              │
         ▼                         │
┌─────────────────┐                │
│ S1: NS YELLOW   │                │
│     EW RED      │                │
└────────┬────────┘                │
         │ Timer Done              │
         ▼                         │
┌─────────────────┐                │
│ S2: NS RED      │                │
│     EW GREEN    │                │
└────────┬────────┘                │
         │ Timer Done              │
         ▼                         │
┌─────────────────┐                │
│ S3: NS RED      │                │
│     EW YELLOW   │                │
└────────┬────────┘                │
         │ Timer Done              │
         └─────────────────────────┘
```

 The FSM repeats this sequence continuously.

---

 # ✨ Features

 - FSM-based traffic light controller
- Designed using **Verilog HDL**
- Implemented on **Digilent Nexys A7 FPGA**
- Synchronous state transitions
- Automatic timing using FPGA clock
- Clock divider for generating slower timing signals
- Reset functionality
- Six traffic-light outputs:
  - NS Red
  - NS Yellow
  - NS Green
  - EW Red
  - EW Yellow
  - EW Green
- RTL simulation using a Verilog testbench
- Synthesized and implemented using **Xilinx Vivado**
- Tested on physical FPGA hardware
- On-board LEDs used to represent traffic lights

---

 # 🧠 FSM Design

 ## States

 The controller contains four states.

 | State | North-South | East-West | Description |
| --- | --- | --- | --- |
| `S0` | 🟢 Green | 🔴 Red | NS traffic allowed |
| `S1` | 🟡 Yellow | 🔴 Red | NS traffic preparing to stop |
| `S2` | 🔴 Red | 🟢 Green | EW traffic allowed |
| `S3` | 🔴 Red | 🟡 Yellow | EW traffic preparing to stop |

After `S3`, the controller returns to `S0`.

---

 ## State Transition Diagram

```
                   timer_done
        ┌────────────────────────────┐
        │                            │
        ▼                            │
   ┌──────────┐                 ┌──────────┐
   │    S0    │                 │    S3    │
   │ NS Green │                 │ EW Yellow│
   │ EW Red   │                 │ NS Red   │
   └────┬─────┘                 └────▲─────┘
        │                            │
        │ timer_done                 │ timer_done
        ▼                            │
   ┌──────────┐                 ┌────┴─────┐
   │    S1    │                 │    S2    │
   │NS Yellow │                 │ EW Green │
   │ EW Red   │                 │ NS Red   │
   └────┬─────┘                 └────▲─────┘
        │                            │
        └────────── timer_done ─────┘
```

 A simpler representation is:

```
S0 → S1 → S2 → S3 → S0 → ...
```

---

 # ⏱️ Timing and Clock Divider

 The Nexys A7 board provides a **100 MHz system clock**.

```
100 MHz
   │
   ▼
Clock Divider
   │
   ▼
Slower Timing Signal
   │
   ▼
Traffic Light FSM
```

 The FPGA clock runs extremely fast compared with the desired traffic-light timing.

 Therefore, a counter is used to divide the 100 MHz clock into a slower timing interval.

 For example, with a 100 MHz clock:

```
Clock frequency = 100 MHz
Clock period     = 10 ns
```

 For approximately a 1-second interval:

```
Required cycles = 100,000,000
```

 Therefore, the counter can count from:

```
0 → 99,999,999
```

 and generate a `timer_done` pulse.

 > **Note:** The exact traffic-light duration can be changed by modifying the counter values in the timer/clock-divider module.

---

 # 🏗️ System Architecture

 The complete design can be divided into three major blocks:

```
                    Nexys A7
                       │
                       │ 100 MHz Clock
                       ▼
              ┌───────────────────┐
              │   Clock Divider    │
              │   / Timer Counter  │
              └─────────┬─────────┘
                        │
                   timer_done
                        │
                        ▼
              ┌───────────────────┐
              │   Traffic Light   │
              │       FSM         │
              └─────────┬─────────┘
                        │
             ┌──────────┴──────────┐
             │                     │
             ▼                     ▼
       North-South LEDs       East-West LEDs
             │                     │
             ▼                     ▼
       R/Y/G indicators        R/Y/G indicators
```

---

 # 🔌 Nexys A7 Hardware

 This project targets the **Digilent Nexys A7 FPGA Development Board**.

 The Nexys A7 is based on a **Xilinx Artix-7 FPGA** and provides a suitable platform for implementing and testing digital designs such as FSMs, counters, timers, communication interfaces, and processor-based systems.

 For this project, the board's:

 - 100 MHz clock
- LEDs
- Push buttons/switches

 can be used for the traffic-light controller.

---

 # 💡 LED Mapping

 The six traffic-light outputs can be connected to six Nexys A7 LEDs.

 Example logical mapping:

 | LED | Signal | Function |
| --- | --- | --- |
| LED0 | `ns_red` | North-South Red |
| LED1 | `ns_yellow` | North-South Yellow |
| LED2 | `ns_green` | North-South Green |
| LED3 | `ew_red` | East-West Red |
| LED4 | `ew_yellow` | East-West Yellow |
| LED5 | `ew_green` | East-West Green |

The LEDs are only a hardware representation of the traffic lights.

 The actual physical LED positions can be changed by modifying the **XDC constraints file**.

---

 # 🔄 Reset Operation

 A reset input is provided to initialize the FSM.

 When reset is asserted:

```
FSM → S0
```

 Therefore, the initial condition becomes:

```
North-South → GREEN
East-West   → RED
```

 This provides a known starting state and prevents the FSM from entering an undefined state.

---

 # 📂 Project Structure

 A recommended repository structure is:

```
Traffic-Light-FSM-Nexys-A7/
│
├── README.md
│
├── rtl/
│   ├── traffic_light.v
│   └── clock_divider.v
│
├── tb/
│   └── traffic_light_tb.v
│
├── constraints/
│   └── nexys_a7.xdc
│
├── simulation/
│   └── waveform/
│
└── docs/
    └── fsm_diagram.png
```

 ### File Description

 | File | Description |
| --- | --- |
| `traffic_light.v` | Main FSM traffic-light controller |
| `clock_divider.v` | Generates slower timing from 100 MHz clock |
| `traffic_light_tb.v` | Testbench for functional simulation |
| `nexys_a7.xdc` | Pin assignments and timing constraints |
| `README.md` | Project documentation |
| `fsm_diagram.png` | FSM state diagram |

---

 # 💻 RTL Design

 The FSM is implemented using three major components:

 ### 1\. State Register

 Stores the current state.

```
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end
```

 ### 2\. Next-State Logic

 Determines the next FSM state.

```
always @(*)
begin
    case (state)

        S0:
            next_state = timer_done ? S1 : S0;

        S1:
            next_state = timer_done ? S2 : S1;

        S2:
            next_state = timer_done ? S3 : S2;

        S3:
            next_state = timer_done ? S0 : S3;

        default:
            next_state = S0;

    endcase
end
```

 ### 3\. Output Logic

 Generates the traffic-light outputs based on the current state.

```
always @(*)
begin
    ns_red    = 0;
    ns_yellow = 0;
    ns_green  = 0;

    ew_red    = 0;
    ew_yellow = 0;
    ew_green  = 0;

    case (state)

        S0: begin
            ns_green = 1;
            ew_red   = 1;
        end

        S1: begin
            ns_yellow = 1;
            ew_red    = 1;
        end

        S2: begin
            ns_red   = 1;
            ew_green = 1;
        end

        S3: begin
            ns_red    = 1;
            ew_yellow = 1;
        end

    endcase
end
```

---

 # 🧪 Simulation and Verification

 Before programming the FPGA, the design can be verified using a Verilog testbench.

 The testbench provides:

 - Clock generation
- Reset generation
- `timer_done` stimulus
- Output monitoring
- FSM transition verification

 The expected sequence is:

```
Reset
  ↓
S0
  ↓
S1
  ↓
S2
  ↓
S3
  ↓
S0
  ↓
Repeat
```

 During simulation, the expected outputs are:

 | State | NS Red | NS Yellow | NS Green | EW Red | EW Yellow | EW Green |
| --- | --- | --- | --- | --- | --- | --- |
| S0 | 0 | 0 | 1 | 1 | 0 | 0 |
| S1 | 0 | 1 | 0 | 1 | 0 | 0 |
| S2 | 1 | 0 | 0 | 0 | 0 | 1 |
| S3 | 1 | 0 | 0 | 0 | 1 | 0 |

This ensures that conflicting green signals are never activated simultaneously.

---

 # 🛠️ Software Requirements

 The following tools are required:

 - **Xilinx Vivado Design Suite**
- Verilog HDL support
- Digilent Nexys A7 board
- USB programming cable
- Computer with Vivado installed

---

 # 🚀 How to Run the Project

 ## Step 1 — Clone the Repository

```
git clone https://github.com/<your-username>/Traffic-Light-FSM-Nexys-A7.git
```

 Navigate to the project:

```
cd Traffic-Light-FSM-Nexys-A7
```

---

 ## Step 2 — Open Vivado

 Open **Xilinx Vivado** and create a new RTL project.

 Select:

```
Project Type:
RTL Project
```

 Add the Verilog source files:

```
traffic_light.v
clock_divider.v
```

 Add the testbench separately under simulation sources:

```
traffic_light_tb.v
```

---

 # 🎯 Step 3 — Select the Nexys A7 FPGA

 Select the FPGA device corresponding to your Nexys A7 board.

 The exact device depends on the board variant.

 For example, the Nexys A7-100T uses an:

```
Artix-7 XC7A100T
```

 Make sure the selected Vivado part matches your physical board.

---

 # 📌 Step 4 — Add XDC Constraints

 The `.xdc` file defines the physical FPGA pins used by the design.

 Typical constraints include:

```
100 MHz clock
Reset button
LED outputs
```

 Example structure:

```
## Clock
set_property PACKAGE_PIN <CLOCK_PIN> [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 [get_ports clk]

## LEDs
set_property PACKAGE_PIN <LED_PIN> [get_ports ns_red]
set_property IOSTANDARD LVCMOS33 [get_ports ns_red]

set_property PACKAGE_PIN <LED_PIN> [get_ports ns_yellow]
set_property IOSTANDARD LVCMOS33 [get_ports ns_yellow]

set_property PACKAGE_PIN <LED_PIN> [get_ports ns_green]
set_property IOSTANDARD LVCMOS33 [get_ports ns_green]
```

 **Do not copy arbitrary pin numbers from another board/project.** Use the official Nexys A7 master XDC for your exact board revision and uncomment the required pins.

---

 # ⚙️ Step 5 — Run Simulation

 In Vivado:

```
Simulation
    ↓
Run Simulation
    ↓
Run Behavioral Simulation
```

 Check the waveform for:

```
state
timer_done
ns_red
ns_yellow
ns_green
ew_red
ew_yellow
ew_green
```

 The FSM should follow:

```
S0 → S1 → S2 → S3 → S0
```

---

 # 🔨 Step 6 — Synthesis

 Run:

```
Run Synthesis
```

 Check for:

 - Syntax errors
- Multiple-driver errors
- Unconnected ports
- Timing issues
- Synthesis warnings

---

 # 🔧 Step 7 — Implementation

 Run:

```
Run Implementation
```

 Vivado performs:

```
Placement
      ↓
Routing
      ↓
Timing Analysis
```

 Check that the design passes timing requirements.

---

 # 💾 Step 8 — Generate Bitstream

 After successful implementation:

```
Generate Bitstream
```

 Vivado generates the FPGA programming file.

---

 # 🔌 Step 9 — Program the Nexys A7

 Connect the Nexys A7 to the computer using the USB programming interface.

 In Vivado:

```
Open Hardware Manager
        ↓
Open Target
        ↓
Auto Connect
        ↓
Program Device
        ↓
Select .bit file
        ↓
Program
```

 After programming, the FPGA begins executing the traffic-light controller.

---

 # 🚦 Hardware Operation

 After programming the FPGA, the LEDs should cycle through the traffic-light states.

 ### State 0

```
NS → 🟢 GREEN
EW → 🔴 RED
```

 ### State 1

```
NS → 🟡 YELLOW
EW → 🔴 RED
```

 ### State 2

```
NS → 🔴 RED
EW → 🟢 GREEN
```

 ### State 3

```
NS → 🔴 RED
EW → 🟡 YELLOW
```

 Then the sequence repeats.

---

 # 🧩 Design Methodology

 The project follows a standard FPGA RTL design flow:

```
             Specification
                  │
                  ▼
             FSM Design
                  │
                  ▼
             Verilog RTL
                  │
                  ▼
             Testbench
                  │
                  ▼
              Simulation
                  │
                  ▼
              Synthesis
                  │
                  ▼
            Implementation
                  │
                  ▼
            Timing Analysis
                  │
                  ▼
            Bitstream Generation
                  │
                  ▼
           Nexys A7 Programming
                  │
                  ▼
          Hardware Verification
```

---

 # 📊 Design Verification

 The following conditions are verified:

 ### Safety

 Only one road should have a green signal at a time.

```
NS_GREEN = 1 → EW_GREEN = 0
EW_GREEN = 1 → NS_GREEN = 0
```

 ### Sequential Operation

 The controller must follow:

```
S0 → S1 → S2 → S3 → S0
```

 ### Reset

 Reset must always return the FSM to:

```
S0
```

 ### Default Recovery

 If the FSM somehow enters an invalid state, the design returns to:

```
S0
```

---

 # 🎓 Concepts Demonstrated

 This project demonstrates practical knowledge of:

 - Finite State Machines
- Moore FSM design
- Verilog HDL
- RTL design
- Sequential logic
- Combinational logic
- Clock division
- Counters
- Timing control
- Reset design
- Testbench development
- Functional simulation
- FPGA synthesis
- FPGA implementation
- Timing analysis
- XDC constraints
- Hardware debugging
- Nexys A7 FPGA development

---

 # 🔮 Possible Future Improvements

 The project can be extended with:

 - 🚗 Vehicle detection using sensors
- 🚶 Pedestrian crossing support
- 🚑 Emergency vehicle priority
- 🌙 Night-mode flashing yellow
- 🚦 Seven-segment countdown timer
- 🔊 Buzzer for pedestrian crossing
- 🔘 Manual traffic control
- 📡 UART-based configuration
- ⚡ Dynamic traffic timing
- 📊 Traffic-density-based signal control

---

 # 📸 Suggested Hardware Demonstration

 For the GitHub repository, it is useful to include a photograph or short video showing the Nexys A7 board running the project.

 Recommended structure:

```
docs/
├── fsm_diagram.png
├── rtl_waveform.png
└── nexys_a7_hardware.jpg
```

 You can then add a hardware demonstration section:

```
## 📸 Hardware Demonstration

The traffic light controller was implemented and tested on the
Digilent Nexys A7 FPGA development board.

![Nexys A7 Hardware](docs/nexys_a7_hardware.jpg)
```

---

 # 📄 Resume Description

 You can use the following description on your resume:

 > **Traffic Light Controller using FSM | Verilog HDL, Xilinx Vivado, Nexys A7**\
>  Designed and implemented an FSM-based traffic light controller in Verilog HDL for a two-road intersection. Developed clock-divider and timer logic using the Nexys A7's 100 MHz FPGA clock, verified FSM transitions through RTL simulation, and synthesized, implemented, and tested the design on the Nexys A7 Artix-7 FPGA using Vivado.

---

 # 👨‍💻 Author

 **Pushpak Srinivas**

 - GitHub: `https://github.com/pushpaksrinivas`

---

 # 📜 License

 This project is open-source and available for educational and personal use.

 Feel free to modify and extend the design for FPGA, RTL, and digital-design learning.

 This README is suitable for a **college/VLSI/FPGA GitHub project** and emphasizes the parts recruiters typically look for: **FSM → RTL → simulation → synthesis → implementation → Nexys A7 hardware testing**.
 

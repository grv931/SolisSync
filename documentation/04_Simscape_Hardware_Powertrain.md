# Simscape Hardware Powertrain

## Introduction

Basic math models are great for testing code, but they don't show how heavy hardware actually behaves in real life. To make my simulation realistic, I deleted the basic math blocks and built a full physical motor system using **Simscape**.

I did this because a real solar tracker has to fight against gravity, motor resistance, friction, and wind. This document explains the electrical and mechanical parts I used to make the simulation act like real hardware.

![Gear ratio configuration](50%20to%201%20gear%20ratio.png)
*Fig: Gear ratio configuration*

---

## 1. The Electrical Setup

To power the simulated motor, I created a basic electrical circuit that is driven by the PID controller:

* **Controlled Voltage Source:** This acts like the power supply. It takes the command from the PID controller and turns it into real electrical voltage.
* **DC Motor Block:** This is the motor itself, which turns electricity into physical spinning motion. I gave it a realistic **Armature Resistance of 0.1 $\Omega$** so it behaves like a real high-torque motor.
* **Electrical Reference (Ground):** This simply grounds the circuit to complete the loop safely.
* **Solver Configuration:** This is just a block Simscape requires to run the complex math for physical simulations.

---

## 2. The Mechanical Setup and Gearbox

You can't just attach a heavy solar panel directly to a spinning motor shaft. It needs extra power and a way to lock in place safely. I added these mechanical parts to help:

* **Mechanical Rotational Reference:** This holds the outside casing of the motor in place so only the inside shaft spins.
* **Gear Box (50:1 Ratio):** I put a gear box between the motor and the panel. A 50:1 ratio means the motor's turning power (torque) is multiplied by 50. This lets a smaller motor move a really heavy panel easily. It also acts like a worm-gear, which locks the panel in place so strong winds can't push it backward when the motor is off.
* **Ideal Rotational Motion Sensor:** This measures the actual physical angle and speed of the spinning shaft.

---

## 3. Connecting the Software and Hardware

Simulink uses standard numbers (like math), but Simscape uses physical signals (like electricity and torque). Because of this, I had to use translation blocks to connect them:

* **Simulink-PS Converter:** This turns the math numbers from the PID controller into a physical control signal for the power supply.
* **PS-Simulink Converter:** This turns the physical angle measured by the motion sensor back into a regular number. I made sure to set its unit to **degrees** (`deg`) so it perfectly matches the sun math I wrote earlier.

---

## 4. Summary

By combining a real electrical motor model, a strong 50:1 gear box, and motion sensors, I built a simulation that acts exactly like a real-world machine. It handles heavy weight, momentum, and electrical resistance, proving the system works beyond just basic math.
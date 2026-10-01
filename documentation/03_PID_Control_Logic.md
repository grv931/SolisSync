# PID Control Logic

## Introduction

Calculating the sun's position with math is only the first step. Once I knew the target angles, the physical motors needed a "brain" to follow that path smoothly without lagging, shaking, or overshooting.

To do this, I designed a **Closed-Loop Feedback Control System** using a **PID (Proportional-Integral-Derivative) Controller**.

<!-- ![Block Diagram](image.png) -->

---

## 1. Why Use Closed-Loop Feedback?

If we used an "open-loop" system, the controller would blindly tell the motor to "spin for 5 seconds" without checking if the panel actually reached the right spot. Wind, friction, or voltage drops could push the panel off-course, and the system would never know.

By using a **closed-loop system**, I made sure the controller constantly checks its own work. The loop runs in a continuous cycle:

1. **Target:** The math says where the sun is.
2. **Action:** The PID controller drives the motor.
3. **Measurement:** A sensor measures the actual angle of the panel.
4. **Correction:** The system calculates the difference and fixes it immediately.

---

## 2. The Sum Block and Error Calculation

At the center of this loop is the **Sum block**, which I set up to subtract the sensor reading from the target. 

We can write the tracking error ($e$) like this:

$$e(t) = \text{Target Angle}(t) - \text{Actual Panel Angle}(t)$$

* If the sun is at 50° and the panel is at 40°, the error is +10°, which tells the motor to push forward.
* If the panel accidentally overshoots to 55°, the error becomes -5°, which tells the motor to run in reverse to fix it.

---

## 3. How the PID Controller Works

The PID controller takes that error number and turns it into an electrical command for the motor. We can break its three parts down simply:

### Proportional (P) — *The Instant Reaction*

* **What it does:** It multiplies the error by a fixed number.
* **Simple analogy:** If you are far away from a stop sign, you drive fast. As you get closer, you slow down. The bigger the error, the harder the motor pushes.

### Integral (I) — *The Memory*

* **What it does:** It adds up tiny errors over time.
* **Simple analogy:** If the wind is blowing hard and the panel is constantly lagging behind the sun by just a tiny bit, the "P" part might not push hard enough to fix it. The "I" part remembers this small lag and slowly builds up power until the panel is perfectly aligned.

### Derivative (D) — *The Brakes*

* **What it does:** It looks at how *fast* the error is changing.
* **Simple analogy:** If the panel is rushing toward the target angle too quickly, the "D" part acts like a brake so it doesn't slam past the target. We use this to stop the heavy panel from swinging back and forth.

---

## 4. Results from the Simulation

When I ran the simulation, we could clearly see the controller working.

![Controlled Elevation Tracking Response](Controlled%20Elevation%20Tracking%20Response.png)
*Fig: Controlled Elevation Tracking Response.*

By combining this PID controller with the physical motor models in Simscape, the system easily handled the heavy weight of the solar panel. It kept the panel tracking the sun smoothly across the whole 12-hour day without shaking or losing control.
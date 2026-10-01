# Project Overview: Dual-Axis Solar Tracker Controller

## Introduction

Solar panels are a great way to generate clean energy, but most standard panels have a big problem: they don't move. Because they are fixed in one place, they only face the sun perfectly for a short time around noon. This means a lot of potential energy is lost during the morning and evening.

For this project, I designed a **Dual-Axis Solar Tracker Controller** using MATLAB and Simulink to fix this issue. Instead of sitting still, my system uses motors to tilt the panel up and down (Elevation) and rotate it left and right (Azimuth). This allows the panel to actively follow the sun and point directly at it from sunrise to sunset.

---

## Project Objectives

My main goals for this project were to:

* **Track the Sun Automatically:** Write a math model that finds the sun's exact position for any location and time of year.
* **Control the Motors:** Use a PID controller to make the motors move smoothly to the right angles without overshooting.
* **Simulate Real Hardware:** Build a physical model using Simscape with real motor values (like resistance and gear ratios) to see how the system handles heavy loads.
* **Check the Efficiency:** Prove that moving the panel on two axes actually captures more energy (around 30% more) than a fixed panel.
* **Add a Reset Feature:** Make sure the system automatically returns the panel to the East after sunset so it's ready for the next day.

---

## System Architecture

To keep the project organized, I split it into three main parts:

1. **Part 1: The Sun Math**
* I wrote a MATLAB function that acts as the brain of the system. You give it a latitude, longitude, and time, and it calculates the exact angles the panel needs to point at.

2. **Part 2: The Control System**
* A feedback loop checks where the panel is currently pointing and compares it to where the sun is. If it's off, it sends an error signal to a PID controller to correct it.

3. **Part 3: The Physical Hardware (Simscape)**
* The software commands drive a simulated physical DC motor. I added a 50:1 gear box to give it enough torque to move a heavy panel and keep it locked in place.

---

## Summary

By combining sun-tracking math with a physical motor simulation, this project shows how theoretical control logic works on real-world hardware. In the following files, I'll explain each part of the project in more detail.
# Dual-Axis Solar Tracker Controller Simulation

## Project Summary

Solar panels are a great way to generate clean energy, but most standard panels sit fixed in one place. Because of this, they only face the sun perfectly for a short time around noon, leading to massive energy losses in the morning and evening.

For this project, I designed a **Dual-Axis Solar Tracker Controller** using MATLAB, Simulink, and Simscape. Instead of staying static, this system uses motors to actively tilt the panel up and down (Elevation) and rotate it left and right (Azimuth) so it always points directly at the sun from sunrise to sunset. 

By tracking the sun perfectly throughout the day, this simulation proves that the dual-axis tracker captures **~30% more energy** than a standard fixed panel!

---

## Documentation

To keep the project organized and easy to follow, I have broken down the work into six detailed parts. Please read through the documentation in the following order to understand how the whole system was built:

1. **[Project Overview](documentation/01_Project_Overview.md)**  
   A high-level look at the project's goals, how it works, and the three main phases of the simulation.

2. **[Solar Mathematics Model](documentation/02_Solar_Mathematics_Model.md)**  
   The math behind the "brain" of the tracker. Explains how I calculate the exact angles (Elevation and Azimuth) of the sun anywhere on Earth.

3. **[PID Control Logic](documentation/03_PID_Control_Logic.md)**  
   How the software controls the motors. Explains the closed-loop feedback system and how the PID controller prevents lagging and overshooting.

4. **[Simscape Hardware Powertrain](documentation/04_Simscape_Hardware_Powertrain.md)**  
   The physical simulation. Details the electrical DC motor, the 50:1 gear box, and how they handle the real-world weight and torque of a heavy solar panel.

5. **[Irradiance and Efficiency Analysis](documentation/05_Irradiance_and_Efficiency_Analysis.md)**  
   The results! A mathematical breakdown proving exactly how much extra power this tracker generates compared to a static panel.

6. **[Fixing and Improving the System](documentation/06_System_Improvements_and_Tuning.md)**  
   Real-world engineering problems I encountered (like the heavy panel swinging too far at sunset) and how I fixed them to make the simulation stable.

---

## Technologies Used
* **MATLAB**: Custom mathematical functions for solar tracking and data analysis.
* **Simulink**: Visual block diagrams for PID control loops and system logic.
* **Simscape**: Physical modeling of electrical motors, gears, and mechanical loads.

---

## Author

 **Kumar Gaurav** - *B.Tech in Electrical and Electronics Engineering, IIIT Bhubaneswar*
<!-- - *B.S in Data Science and applications, IIT Madras* -->
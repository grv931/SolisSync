# Fixing and Improving the System


The solar tracker works perfectly to follow the sun and boosts energy capture by about 30%. However, building a realistic simulation showed a few mechanical issues, like the heavy panel swinging too far when it resets at night. This document explains these real-world problems, how I fixed them, and ideas for future upgrades.

![Controlled Azimuth Tracking Response](Controlled%20Azimuth%20Tracking%20Response.png)
*Fig: Controlled Azimuth Tracking Response.*

---

## 1. The Sunset Overshoot (Heavy Swinging)

When the sun sets, the panel needs to quickly turn from West (180°) back to East (0°) to get ready for the next morning. 

At first, the software told the motor to jump to this new position instantly. Because the solar panel is heavy and uses powerful gears, spinning it backward so fast created too much momentum. When the motor tried to stop at 0°, the heavy panel swung right past the mark, creating a bumpy, stressful movement that could damage real hardware.

---

## 2. Fixing the Overshoot

To stop this harsh swinging and protect the system, I fixed the math logic directly:

* **A Smooth 5-Minute Reset:** Instead of telling the motor to snap back instantly, I changed the MATLAB code to slowly rewind the panel over exactly 5 minutes. By giving the motor a gentle, sloped command instead of an instant cliff, it completely stopped the violent swinging and allowed the panel to reset smoothly.

---

## 3. Fixing a Math Crash at Midnight

When I ran the simulation for a full 24 hours, the software crashed exactly at midnight. 

This happened because of a tiny rounding error in the computer's math. At exactly midnight, the code tried to process an impossible number (slightly larger than what a cosine function allows), which broke the calculation. I fixed this by adding a simple safety limit in the code to block any impossible numbers. This small change stops the crash and lets the simulation run flawlessly for days at a time.

---

## 4. Ideas for Future Upgrades

To turn this project into a real commercial product, we could add a few smart safety features:

* **Cloud and Storm Mode:** Adding a light sensor that tells the panel to lie flat and save motor power when it is too cloudy to track the sun.
* **High Wind Protection:** Adding a wind speed sensor to automatically flatten the panel during heavy storms so it doesn't act like a sail and break.
* **Extra Light Sensors:** Mixing our math-based tracking with small physical light sensors to fix tiny installation mistakes once the panel is placed on a roof.

---

## Conclusion

Fixing these issues proved that this solar tracker is not just a math project, but a stable, realistic machine ready to be built in the real world.
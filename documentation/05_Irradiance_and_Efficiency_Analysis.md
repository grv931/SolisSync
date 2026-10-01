# Irradiance and Efficiency Analysis 

## Introduction

Building a complex system with gears and motors is only worth it if it actually gives us more power. To prove that this project works, I wrote a MATLAB script to calculate and compare exactly how much solar energy a standard fixed panel captures versus my moving dual-axis tracker.

This document explains the physics of sunlight and the math that proves the tracker is more efficient.

![Daily Solar Energy Comparison](solar%20comparison.png)
*Fig: Daily solar energy comparison*

---

## 1. Direct Normal Irradiance (DNI)

Before we figure out how much power the panel gets, we first need to know how much raw power the sun is actually sending to Earth. This is called Direct Normal Irradiance (DNI).

As sunlight travels through the Earth's atmosphere, it loses some power. When the sun is low in the sky, the light has to travel through more air (this is called "Air Mass") than when it's directly overhead.

To calculate this, I used standard formulas for a clear sky:

* **Air Mass ($AM$):**

$$AM = \frac{1}{\sin(\alpha) + 0.0001}$$

*(Where $\alpha$ is the elevation angle, and 0.0001 just stops the math from breaking by dividing by zero at sunrise/sunset).*

* **DNI ($W/m^2$):**

$$DNI = 1367 \times 0.7^{AM}$$

*(Where 1367 is the solar constant in Watts per square meter, and 0.7 is a standard number for how much light gets through a clear sky).*

---

## 2. The Angle of Incidence ($\theta$) and Cosine Loss

The most important rule in solar energy is that a panel only captures 100% of the sun's power if the light hits it perfectly straight on. The angle between the sun's rays and the flat face of the solar panel is called the **Angle of Incidence ($\theta$)**.

If the sun hits the panel at a sharp angle, most of the light bounces off the glass and the energy is lost. The amount of power captured drops based on the cosine of this angle ($\cos(\theta)$).

---

## 3. Case 1: The Static Panel

Most rooftop panels are just bolted down and never move. For my baseline test, I simulated a standard fixed panel set up perfectly for Bhubaneswar: tilted at the local latitude (~20.3°) and facing directly South (180°).

We calculate the angle of incidence for a fixed panel using this formula:

$$\cos(\theta_{fixed}) = \sin(\alpha)\cos(\beta) + \cos(\alpha)\sin(\beta)\cos(\gamma - \gamma_{panel})$$

*(Where $\alpha$ is solar elevation, $\beta$ is panel tilt, $\gamma$ is solar azimuth, and $\gamma_{panel}$ is panel azimuth).*

Because the sun moves across the sky but the panel stays still, this angle is really bad in the morning and evening. This causes massive power losses.

---

## 4. Case 2: The Dual-Axis Tracking Panel

This is where my tracker system shines. Because the PID controllers and motors constantly move the panel to point exactly at the sun, the sun's rays always hit the panel perfectly straight on.

For my tracking panel, the angle of incidence is always exactly zero ($\theta = 0^\circ$).
Since **$\cos(0^\circ) = 1$**, the tracker captures 100% of the available sunlight all day long:

$$\text{Power}_{Tracking} = DNI \times 1$$

---

## 5. Total Daily Energy Calculation

To find out exactly how much extra energy I collected over the whole day, I couldn't just look at one specific time. I had to calculate the total energy from sunrise (6 AM) to sunset (6 PM).

I used MATLAB's `trapz` function to calculate the total "area under the curve" for both power graphs, giving me the total daily energy.

**The Final Result:**
By running this test for Day 80 (the Spring Equinox) in Bhubaneswar, the data proved that my dual-axis tracking system captured **~29.8% more total daily energy** compared to a perfectly placed fixed panel. This proves that all the mechanical and software design was actually worth it!
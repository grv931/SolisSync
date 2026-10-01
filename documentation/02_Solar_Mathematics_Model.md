# Solar Mathematics Model

## Introduction

Before a motor can move the solar panel, the system needs to know exactly where the sun is. Because the Earth is tilted and moves around the sun, the sun's position changes depending on where you are, the time of day, and the time of year. 

This document explains the math formulas I used in my MATLAB function to find the sun.

---

## 1. What We Need to Start (Inputs)

To calculate the sun's path, my math model needs a few basic pieces of information:

* **Latitude (**$\phi$**):** How far north or south we are (for example, 20.2961° for Bhubaneswar).
* **Longitude (**$L$**):** How far east or west we are (for example, 85.8245° for Bhubaneswar).
* **Time Zone (**$TZ$**):** The local time offset from UTC (like +5.5 for India).
* **Day of the Year (**$n$**):** A number from 1 to 365 (like day 80 for the Spring Equinox around March 21).

![Earth's axis tilt](Earth's%20axis%20tilt.png)
*Fig: Earth's axis tilt.*

---

## 2. Step-by-Step Math

We can't just use regular clock time to find the sun because the Earth's orbit isn't a perfect circle. We have to calculate **True Solar Time**.

### Step A: Equation of Time (EoT)

Because the Earth's speed changes slightly throughout the year, this formula gives us a small time correction (in minutes) to account for that:

$$B = \frac{360}{365}(n - 81)$$

$$EoT = 9.87 \sin(2B) - 7.53 \cos(B) - 1.5 \sin(B)$$

### Step B: Time Correction Factor ($TC$)

This step adjusts our regular clock time based on our exact longitude compared to the standard time zone line ($LSTM = 15 \times TZ$):

$$TC = 4(L - LSTM) + EoT$$

### Step C: Local Solar Time ($LST$)

By adding this time correction to the normal clock time ($Lt$), we get the "True Solar Time":

$$LST = Lt + \frac{TC}{60}$$

### Step D: Declination Angle ($\delta$)

This angle tells us how high or low the sun looks relative to the Earth's equator depending on the time of year:

$$\delta = 23.45 \sin\left(\frac{360}{365}(n - 81)\right)$$

### Step E: Hour Angle ($\omega$)

This angle measures how far the sun has moved from solar noon (when the sun is highest). Since the Earth spins 15° every hour, 12:00 PM is 0°:

$$\omega = 15(LST - 12)$$

---

## 3. Finding Elevation and Azimuth

Now that we have those basic angles, we can calculate the two main directions the tracker motors actually use:

### Elevation Angle ($\alpha$)

This is how high the sun is above the horizon (the up-and-down tilt):

$$\alpha = \arcsin(\sin(\phi)\sin(\delta) + \cos(\phi)\cos(\delta)\cos(\omega))$$

### Azimuth Angle ($\gamma$)

This is the compass direction of the sun (left-to-right rotation). (0° = North, 90° = East, 180° = South, 270° = West):

$$\cos(\gamma) = \frac{\sin(\delta) - \sin(\phi)\sin(\alpha)}{\cos(\phi)\cos(\alpha)}$$

*Note: The math gives us a symmetrical shape, so in the afternoon (when the hour angle* $\omega > 0$*), we have to flip the azimuth using* $\gamma = 360^\circ - \gamma$*. Finally, we subtract 90° so it perfectly lines up with the starting position of our physical motor (where East is 0°).*

![Azimuth and Elevation angle graph](dual-plot%20graph%20for%20true%20elevation%20and%20true%20azimuthal%20angle.png)
*Fig: Dual-plot graph for true elevation and true azimuthal angle.*

---

## 4. Resetting at Night

We can't just leave the solar panel facing West all night. When the sun goes down, the system has to spin the panel back to face East so it's ready for the next morning. 

I wrote a specific rule in my code to handle this smoothly:

* **Daytime (6:00 AM to 6:00 PM):** The motors follow the calculated Elevation and Azimuth angles to track the sun.
* **5-Minute Rewind (6:00 PM to 6:05 PM):** To avoid breaking the motor by snapping it back instantly, the code makes the panel slowly rotate from 180° back to 0° over 5 minutes.
* **Nighttime (After 6:05 PM until 6:00 AM):** The panel is parked flat and facing East ($\alpha = 0^\circ$, $\gamma = 0^\circ$) so it safely waits for the sun to rise again.
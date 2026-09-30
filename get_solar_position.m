function [elevation, azimuth] = get_solar_position(lat, lon, timezone, day, time_hr)
% Calculates true solar elevation and azimuth angles using exact solar time
% Inputs: 
%   lat      - Latitude in degrees
%   lon      - Longitude in degrees
%   timezone - UTC offset (e.g., +5.5 for IST)
%   day      - Day of the year (1-365)
%   time_hr  - Array of local clock time in hours

% 1. Local Standard Time Meridian (LSTM)
LSTM = 15 * timezone;

% 2. Equation of Time (EoT) in minutes
% Accounts for Earth's elliptical orbit and axial tilt
B = (360 / 365) * (day - 81);
EoT = 9.87 * sind(2 * B) - 7.53 * cosd(B) - 1.5 * sind(B);

% 3. Time Correction Factor (TC) in minutes
TC = 4 * (lon - LSTM) + EoT;

% 4. Local Solar Time (LST) in hours
LST = time_hr + (TC / 60);

% 5. Hour Angle (omega) using Local Solar Time
omega = 15 .* (LST - 12);

% 6. Declination Angle (delta)
delta = 23.45 * sind((360/365) * (day - 81)); 

% 7. Calculate Elevation
elevation = asind(sind(lat)*sind(delta) + cosd(lat)*cosd(delta).*cosd(omega));

% 8. Calculate Azimuth
cos_az = (sind(delta) - sind(lat).*sind(elevation)) ./ (cosd(lat).*cosd(elevation));
azimuth = acosd(cos_az);

% Adjust azimuth for the solar afternoon (when Hour Angle > 0)
afternoon_idx = omega > 0;
azimuth(afternoon_idx) = 360 - azimuth(afternoon_idx);
end
% SOLAR TRACKER: IRRADIANCE COMPARISON
clear; clc; close all;

% 1. Setup Parameters (Bhubaneswar, Spring Equinox)
lat = 20.2961; 
day = 80;      
time_hr = 6:0.1:18; % Higher resolution (every 6 mins) for smoother math

% 2. Calculate Sun Position (Using my exact math)
delta = 23.45 * sind((360/365) * (day - 81));
omega = 15 * (time_hr - 12);
elevation = asind(sind(lat)*sind(delta) + cosd(lat)*cosd(delta).*cosd(omega));

cos_az = (sind(delta) - sind(lat).*sind(elevation)) ./ (cosd(lat).*cosd(elevation));
azimuth = acosd(cos_az);
azimuth(time_hr > 12) = 360 - azimuth(time_hr > 12);

% Prevent negative elevation (sun below horizon) from breaking the physics
elevation(elevation < 0) = 0; 

% 3. Calculate Direct Normal Irradiance (DNI)
% This models the actual power of the sun based on how much atmosphere it passes through.
AM = 1 ./ (sind(elevation) + 0.0001); % Air Mass
DNI = 1367 * (0.7 .^ AM); % W/m^2 (Standard clear-sky model)
DNI(elevation <= 0) = 0;

% 4. CASE 1: Static Solar Panel
% A standard fixed panel is tilted at the local latitude and faces True South (180 deg)
panel_tilt = lat;
panel_azimuth = 180;

% The original geometrical formula for the angle of incidence on a fixed surface
cos_theta_fixed = sind(elevation).*cosd(panel_tilt) + ...
    cosd(elevation).*sind(panel_tilt).*cosd(azimuth - panel_azimuth);
cos_theta_fixed(cos_theta_fixed < 0) = 0; % Ignore if the sun is behind the panel

Irradiance_Fixed = DNI .* cos_theta_fixed;

% 5. CASE 2: Dual-Axis Tracking Panel
% The panel is always perfectly perpendicular to the sun. cos(0) = 1.
Irradiance_Tracking = DNI .* 1;

% 6. Calculate Total Energy & Percentage Increase
% trapz calculates the "area under the curve" to give me total daily energy
Energy_Fixed = trapz(time_hr, Irradiance_Fixed);
Energy_Tracking = trapz(time_hr, Irradiance_Tracking);
Increase_Percent = ((Energy_Tracking - Energy_Fixed) / Energy_Fixed) * 100;

% 7. Plot the Comparison (Dark Mode Formatting)
fig = figure('Color', '#1E1E1E'); % Dark background for the whole window
hold on;

% Fill the area between the curves
fill([time_hr, fliplr(time_hr)], [Irradiance_Tracking, fliplr(Irradiance_Fixed)], ...
     [0.4660 0.6740 0.1880], 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'DisplayName', 'Extra Energy Captured');

% Plot the curves
plot(time_hr, Irradiance_Fixed, 'LineWidth', 2, 'Color', '#0072BD', 'DisplayName', 'Static Panel');
plot(time_hr, Irradiance_Tracking, 'LineWidth', 2, 'Color', '#D95319', 'DisplayName', 'Tracking Panel');

% Axis Formatting
ax = gca;
ax.Color = '#151515'; % Dark inner plot area
ax.XColor = 'w';      % White X-axis text and ticks
ax.YColor = 'w';      % White Y-axis text and ticks
ax.GridColor = 'w';   % White grid lines

% Title and Labels
t = title(sprintf('Daily Solar Energy Comparison (Increase: %.1f%%)', Increase_Percent));
t.Color = 'w';
t.FontSize = 12;

xlabel('Time of Day (Hours)', 'Color', 'w', 'FontSize', 11);
ylabel('Irradiance / Power (W/m^2)', 'Color', 'w', 'FontSize', 11);

% Legend Formatting
lgd = legend('Location', 'south');
lgd.TextColor = 'w';
lgd.Color = 'none';   % Transparent legend background
lgd.Box = 'off';

grid on;
hold off;
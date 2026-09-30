% SOLAR TRACKER: MAIN TEST SCRIPT
clear; clc; close all;

% 1. Select Location & Timezone
target_location = 'Bhubaneswar'; % Options: 'Bhubaneswar', 'Kolkata', 'Goa'
timezone = 5.5; % UTC offset for Indian Standard Time (IST)

switch lower(target_location)
    case 'bhubaneswar'
        latitude = 20.2961;
        longitude = 85.8245;
    case 'kolkata'
        latitude = 22.5726;
        longitude = 88.3639;
    case 'goa'
        latitude = 15.2993;
        longitude = 74.1240;
    otherwise
        warning('Location not found. Defaulting to 0,0.');
        latitude = 0;
        longitude = 0;
end

fprintf('Configured for %s (Lat: %.4f, Lon: %.4f, UTC+%.1f)\n', ...
    target_location, latitude, longitude, timezone);

% 2. Define Time Parameters
day_of_year = 80;      % Spring Equinox
time_array = 6:0.5:18; % 6 AM to 6 PM local clock time

% 3. Call the exact solar math function
[elev, azim] = get_solar_position(latitude, longitude, timezone, day_of_year, time_array);

% 4. Plot Results
figure;
subplot(2,1,1);
plot(time_array, elev, 'LineWidth', 2, 'Color', '#D95319');
title(sprintf('True Solar Elevation Angle for %s', target_location));
ylabel('Degrees'); grid on;

subplot(2,1,2);
plot(time_array, azim, 'LineWidth', 2, 'Color', '#0072BD');
title(sprintf('True Solar Azimuth Angle for %s', target_location));
xlabel('Local Clock Time (Hours)');
ylabel('Degrees'); grid on;
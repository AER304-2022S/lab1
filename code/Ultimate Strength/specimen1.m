load("../../data/processed_labview/specimens.mat")

specimenn1 = specimens(1);
load1 = specimenn1{1}.load;
strain = specimenn1{1}.strain_axial;
laser = specimenn1{1}.laser;
laser = laser(20:end);
laser =(laser - laser(1))/50;
l = size(laser)
% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (14.83+14.88+14.81)/3;
thickness_avg = (3.29+3.32+3.46)/3;
area = width_avg*thickness_avg;

eng_stress = load1/area; % This is the engineering stress because it is divided by the original cross-sectional area and not the instantaneous area
e = size(eng_stress)
max_stress = max(eng_stress)
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress
laser_strain_at_max_stress = laser(find(eng_stress == max_stress)-20);

% Strain Gauge vs. Stress
figure
hold on
plot(strain, eng_stress)
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Strain Gauge - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Engineering Strain Plot for specimen 1");
legend("stress-Strain relationship", "Ultimate Strength = 74.647 N/m^2", "location", "Southeast");
hold off

% Laser Strain vs. Stress (BETTER one)
figure
hold on
plot(laser, eng_stress(20:634))
plot(laser_strain_at_max_stress, max_stress, 'o')
xlabel("Laser Strain - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Laser Strain Plot for specimen 1");
legend("Stress-Strain relationship", "Ultimate Strength = 74.647 N/m^2", "location", "Southeast");
hold off


load("../../data/processed_labview/specimens.mat")

specimenn2 = specimens(2);
load2 = specimenn2{1}.load;
strain = specimenn2{1}.strain_axial;
laser = specimenn2{1}.laser;
laser = laser(25:710);
laser=(laser - laser(1))/50;

% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (15.09+15.08+15.03)/3;
thickness_avg = (3.21+3.37+3.2)/3;
area = width_avg*thickness_avg;

eng_stress = load2/area; 
max_stress = max(eng_stress)
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress
laser_strain_at_max_stress = laser(find(eng_stress == max_stress)-20); % laser strain at max stress

% Strain gauge vs. stress
figure
hold on
plot(strain, eng_stress) % cuts out the deload 
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Strain Gauge - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Engineering Strain Plot for specimen 2");
legend("stress-Strain relationship", "Ultimate Strength = 549.3317 N/m^2", "location", "Southeast");
hold off
saveas(gcf, 'US_specimen2_strain_gauge.pdf')

% Laser Strain vs. stress (BETTER)
figure
hold on
plot(laser, eng_stress(25:710)) % cuts out the weird stuff at beginning
plot(laser_strain_at_max_stress, max_stress, 'o')
xlabel("Laser Strain - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Lasor Strain Plot for specimen 2");
legend("Stress-Strain relationship", "Ultimate Strength = 549.3317 N/m^2", "location", "Southeast");
hold off
saveas(gcf, 'US_specimen2_laser.pdf')

load("../../data/processed_labview/specimens.mat")

specimenn5 = specimens(5);
load5 = specimenn5{1}.load;
strain = specimenn5{1}.strain_axial;
laser = specimenn5{1}.laser;
laser = laser(20:end); % cuts out the first 20 data points
laser = (laser - laser(1))/50;

% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (15.07+15.14+15.11)/3;
thickness_avg = (3.29+3.27+3.29)/3;
area = width_avg*thickness_avg;

eng_stress = load5/area; 
max_stress = max(eng_stress)
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress
laser_strain_at_max_stress = laser(find(eng_stress == max_stress)-20); % laser strain at max stress

% Strain Gauge vs. Stress
figure
hold on
plot(strain, eng_stress)
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain, $\epsilon$, (  )", "Interpreter", "latex")
ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
title("Ultimate Tensile Stress (MPa), Strain Gauge", "Interpreter", "latex");
legend("stress-Strain relationship", "Ultimate Strength = 998.489 MPa", "location", "Southeast","Interpreter", "latex");
grid on
hold off
saveas(gcf, 'US_specimen5_strain_gauge.pdf')

% Laser strain vs. stress
figure
hold on
plot(laser, eng_stress(20:end))
plot(laser_strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain, $\epsilon$, (  )", "Interpreter", "latex")
ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
title("Ultimate Tensile Stress (MPa), Lasor Extensometer", "Interpreter", "latex");
legend("Stress-Strain relationship", "Ultimate Strength = 998.489 MPa", "location", "Southeast","Interpreter", "latex");
grid on
hold off
saveas(gcf, 'US_specimen5_laser.pdf')
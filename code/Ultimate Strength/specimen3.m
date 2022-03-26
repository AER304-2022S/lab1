load("../../data/processed_labview/specimens.mat")

specimenn3 = specimens(3);
load3 = specimenn3{1}.load;
strain = specimenn3{1}.strain_axial;
laser = specimenn3{1}.laser;
laser = laser(20:end);
laser = (laser - laser(1))/50;

% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (14.98+14.96+14.96)/3;
thickness_avg = (3.22+3.25+3.21)/3;
area = width_avg*thickness_avg;

eng_stress = load3/area;
max_stress = max(eng_stress(1:end))
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress
laser_strain_at_max_stress = laser(find(eng_stress == max_stress)-20);

% Stress vs. Strain Gauge
figure
plot(strain, eng_stress) % cuts out the weird stuff 
hold on
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain, $\epsilon$, (mm/mm)", "Interpreter", "latex")
ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
title("Ultimate Tensile Stress (MPa), Strain Gauge", "Interpreter", "latex");
legend("Stress-Strain relationship", "Ultimate Strength = 266.2830 MPa", "location", "Southeast","Interpreter", "latex");
grid on
saveas(gcf, '../../figures/US_specimen3_strain_gauge.pdf')

% Stress vs. Laser Strain
figure
plot(laser, eng_stress(20:end)) % cuts out the weird stuff at beginning
hold on
plot(laser_strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain, $\epsilon$, (mm/mm)", "Interpreter", "latex")
ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
title("Ultimate Tensile Stress (MPa), Laser Extensometer", "Interpreter", "latex");
legend("Stress-Strain relationship", "Ultimate Strength = 266.2830 MPa", "location", "Southeast","Interpreter", "latex");
grid on
saveas(gcf, '../../figures/US_specimen3_laser.pdf')


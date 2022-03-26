load("../../data/processed_labview/specimens.mat")

specimenn4 = specimens(4);
load4 = specimenn4{1}.load;
strain = specimenn4{1}.strain_axial;
laser = specimenn4{1}.laser;
laser = laser(20:1289); % cuts out the first 20 data points
laser_strain = (laser - laser(1))/50;


% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (14.95+14.94+14.95)/3;
thickness_avg = (3.14+3.13+3.1)/3;
area = width_avg*thickness_avg;

eng_stress = load4/area;
max_stress = max(eng_stress)
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress
laser_strain_max = laser_strain(find(eng_stress == max_stress) - 20); % Laser strain at the max stress


%Plot with the strain gauge 

figure
plot(strain, eng_stress)
hold on
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain, $\epsilon$, (mm/mm)", "Interpreter", "latex")
ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
title("Ultimate Tensile Stress (MPa), Strain Gauge", "Interpreter", "latex");
legend("Stress-Strain relationship", "Ultimate Strength = 641.9521 MPa", "location", "Southeast","Interpreter", "latex");
grid on
saveas(gcf, '../../figures/US_specimen4_strain_gauge.pdf')

% Laser Strain vs. Stress (BETTER PLOT)
figure
plot(laser_strain, eng_stress(20:1289))
hold on
plot(laser_strain_max, max_stress, 'o')
xlabel("Engineering Strain, $\epsilon$, (mm/mm)", "Interpreter", "latex")
ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
title("Ultimate Tensile Stress (MPa), Laser Extensometer", "Interpreter", "latex");
legend("Stress-Strain relationship", "Ultimate Strength = 641.9521 MPa", "location", "Southeast","Interpreter", "latex");
grid on
saveas(gcf, '../../figures/US_specimen4_laser.pdf')


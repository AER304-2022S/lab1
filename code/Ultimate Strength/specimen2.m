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
plot(strain, eng_stress) % cuts out the deload 
hold on
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain, $\epsilon$, (mm/mm)", "Interpreter", "latex")
ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
title("Ultimate Tensile Stress (MPa), Strain Gauge", "Interpreter", "latex");
legend("stress-Strain relationship", "Ultimate Strength = 549.3317 MPa", "location", "Southeast","Interpreter", "latex");
grid on
saveas(gcf, '../../figures/US_specimen2_strain_gauge.pdf')

% Laser Strain vs. stress (BETTER)
figure
plot(laser, eng_stress(25:710)) % cuts out the weird stuff at beginning
hold on
plot(laser_strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain, $\epsilon$, (mm/mm)", "Interpreter", "latex")
ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
title("Ultimate Tensile Stress (MPa), Laser Extensometer", "Interpreter", "latex");
legend("Stress-Strain relationship", "Ultimate Strength = 549.3317 MPa", "location", "Southeast","Interpreter", "latex");
grid on
saveas(gcf, '../../figures/US_specimen2_laser.pdf')

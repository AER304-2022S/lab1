load("../../data/processed_labview/specimens.mat")

specimenn4 = specimens(4);
load4 = specimenn4{1}.load;
strain = specimenn4{1}.strain_axial;

% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (14.95+14.94+14.95)/3;
thickness_avg = (3.14+3.13+3.1)/3;
area = width_avg*thickness_avg;

eng_stress = load4/area;
max_stress = max(eng_stress)
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress

hold on
plot(strain, eng_stress)
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Engineering Strain Plot for specimen 4");
legend("stress-Strain relationship", "Ultimate Strength = 641.9521 N/m^2", "location", "Southeast");
hold off
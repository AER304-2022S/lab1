load("../../data/processed_labview/specimens.mat")

specimenn5 = specimens(5);
load5 = specimenn5{1}.load;
strain = specimenn5{1}.strain_axial;

% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (15.07+15.14+15.11)/3;
thickness_avg = (3.29+3.27+3.29)/3;
area = width_avg*thickness_avg;

eng_stress = load5/area; 
max_stress = max(eng_stress);
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress

hold on
plot(strain, eng_stress)
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Engineering Strain Plot for specimen 5");
legend("stress-Strain relationship", "Ultimate Strength = 998.489 N/m^2", "location", "Southeast");
hold off
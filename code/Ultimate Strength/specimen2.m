load("../../data/processed_labview/specimens.mat")

specimenn2 = specimens(2);
load2 = specimen1{1}.load;
strain = specimenn2{1}.strain_axial;

% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (15.09+15.08+15.03)/3;
thickness_avg = (3.21+3.37+3.2)/3;
area = width_avg*thickness_avg;

eng_stress = load2/area; 
max_stress = max(eng_stress);
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress

hold on
plot(strain(1:500), eng_stress(1:500)) % cuts out the deload 
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Engineering Strain Plot for specimen 2");
legend("stress-Strain relationship", "Ultimate Strength = 75.7042 N/m^2", "location", "Southeast");
hold off
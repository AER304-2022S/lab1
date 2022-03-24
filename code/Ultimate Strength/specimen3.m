load("../../data/processed_labview/specimens.mat")

specimenn3 = specimens(3);
load3 = specimenn3{1}.load;
strain = specimenn3{1}.strain_axial;

% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (14.98+14.96+14.96)/3;
thickness_avg = (3.22+3.25+3.21)/3;
area = width_avg*thickness_avg;

eng_stress = load3/area;
max_stress = max(eng_stress(1:300));
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress

hold on
plot(strain(1:300), eng_stress(1:300)) % cuts out the weird stuff?? 
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Engineering Strain Plot for specimen 3");
legend("stress-Strain relationship", "Ultimate Strength = 240.015 N/m^2", "location", "Southeast");
hold off
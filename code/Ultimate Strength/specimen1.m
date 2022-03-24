load("../../data/processed_labview/specimens.mat")

specimenn1 = specimens(1);
load1 = specimenn1{1}.load;
strain = specimenn1{1}.strain_axial;

% Original Cross-Sectional Area
% Measurements contain error!
width_avg = (14.83+14.88+14.81)/3;
thickness_avg = (3.29+3.32+3.46)/3;
area = width_avg*thickness_avg;

eng_stress = load1/area; % This is the engineering stress because it is divided by the original cross-sectional area and not the instantaneous area
max_stress = max(eng_stress);
strain_at_max_stress = strain(find(eng_stress == max_stress)); % strain at the max stress

hold on
plot(strain, eng_stress)
plot(strain_at_max_stress, max_stress, 'o')
xlabel("Engineering Strain - dimensionaless");
ylabel("Engineering Stress - N/m^2");
title("Engineering Stress vs. Engineering Strain Plot for specimen 1");
legend("stress-Strain relationship", "Ultimate Strength = 74.647 N/m^2", "location", "Southeast");
hold off


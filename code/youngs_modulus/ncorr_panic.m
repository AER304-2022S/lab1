load("../../data/processed_labview/specimens.mat", "specimens");


E = zeros(1, 5);

indices = [101, 144, 144, 30, 302];
times = [105, 150, 150, 30, 315];
offsets = [-30 0 0 0 0];
images = times / 15;

axial_strains = [0.0012, 0.0007, 0.0003, 0.0002, 0.025];

for i = 1:5
    stress = specimens{i}.stress(indices(i)+offsets(i))
    reference = specimens{i}.strain_axial(indices(i))
    E(i) = stress / axial_strains(i) / 1000
    E_ref = stress / reference / 1000;
end
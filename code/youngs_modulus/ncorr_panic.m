load("../../data/processed_labview/specimens.mat", "specimens");

i = 1;

indices = [101, 144, 144, 30, 302];
times = [105, 150, 150, 30, 315];
offsets = [0 0 0 0 0];
images = times / 15;

axial_strains = []


stress = specimens{i}.stress(indices(i))


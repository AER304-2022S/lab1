specimens = cell(1,5);

for i = 1:5
    A = readmatrix(...
        sprintf("../../data/labview/specimen%d.txt", i));
    A = A(10:end, 2:end-1);
    time = A(:, 1);
    load = A(:, 2);
    mts_extension = A(:, 3);
    laser = A(:, 4);
    
    switch i
        case {1, 2, 4}
            strain_axial = A(:, 5);
            strain_poisson = A(:, 6);
        case {3, 5}
            strain_axial = A(:, 6);
            strain_poisson = A(:, 5);
    end
    
    subplot(3, 2, i)
    plot(strain_axial, load);
    title(sprintf("Specimen %d", i))
    
    specimens{i} = table(time, load, mts_extension, strain_axial, strain_poisson);
end
save ../../data/processed_labview/specimens.mat specimens




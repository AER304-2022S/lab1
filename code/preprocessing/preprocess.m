areas = specimen_areas(); % mm^2

specimens = cell(1,5); % Initialize empty cell array for each specimen

for i = 1:5
    % Read Raw data
    A = readmatrix(...
        sprintf("../../data/labview/specimen%d.txt", i));
    
    % TRIM the array down to remove the headers
    A = A(10:end, 2:end-1);
    
    % extract the various rows
    time = A(:, 1); % s
    load = A(:, 2); % N
    mts_extension = A(:, 3); % mm
    laser = A(:, 4); % mm
    stress = load / areas(i); % MPa
    
    switch i
        case {1, 2, 4}
            strain_axial = A(:, 5);
            strain_poisson = A(:, 6);
        case {3, 5}
            strain_axial = A(:, 6);
            strain_poisson = A(:, 5);
    end
    
    subplot(3, 2, i)
    plot(strain_axial, stress);
    xlabel("Strain");
    ylabel("Engineering Stress (MPa)")
    title(sprintf("Specimen %d", i))
    
    specimens{i} = table(time, load, mts_extension, laser,...
        strain_axial, strain_poisson, stress);
end
save ../../data/processed_labview/specimens.mat specimens




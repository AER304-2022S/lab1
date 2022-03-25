function [masses, uncertainty] = specimen_masses()
    % Read the material property measurements we took
    properties = readmatrix("../../data/specimen_properties.csv");

    % Calculate average area
    masses = properties(:, 8);
    uncertainty = 0.01 ./ masses; %relative
end
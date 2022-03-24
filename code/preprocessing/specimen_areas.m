function [areas, uncertainty] = specimen_areas()
    % Read the material property measurements we took
    properties = readmatrix("../../data/specimen_properties.csv");

    % Calculate average area
    avg_width = mean(properties(:, 2:4), 2);
    avg_height = mean(properties(:, 5:7), 2);
    areas = avg_width .* avg_height;
    
    % TODO
    uncertainty = zeros(length(areas));
end
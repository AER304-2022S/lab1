function [plot_limit, elastic_limit, stress, strain, laser] = ...
    yield_preprocess(specimen)

    load("../../data/processed_labview/specimens.mat", "specimens");
    
    stress = specimens{specimen}.stress;
    strain = specimens{specimen}.strain_axial;
    laser = specimens{specimen}.laser;

    switch specimen
        % elastic_limit: Only linear fit using the first ___ datapoints
        % plot_limit: Only plot the first __ datapoints
        case 1
            elastic_limit = 200;
            plot_limit = 500;
        case 2
            elastic_limit = 350; 
            plot_limit = 450; 
        case 3
            elastic_limit = 200;
            plot_limit = 270;
        case 4
            elastic_limit = 200;
            plot_limit = 250;
        case 5
            elastic_limit = 400;
            plot_limit = 548;
    end
    
    
end
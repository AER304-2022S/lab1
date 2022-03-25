clear; clc; hold off;
load ../../data/processed_labview/specimens.mat

% We want to fiind the poisson's Ratio here, which is simply the ratio of
% transverse to axial strain. These were measured directly by the strain
% gauges, so we can calculate them directly.

% We dont want all the data, since the first bits and end are noisy from
% when the strain gauge is getting settled and falling off.

lower = [120,60,75,120];
upper = [450,450,300,625];


for i = 1:4 % We didn't hae a strain gauge for sample five, NICE
    current = specimens{i};
    
    axial = current.strain_axial(lower(i):upper(i),1); % Pulling the axial strains
    lateral = current.strain_poisson(lower(i):upper(i),1); % Pulling the lateral strains
    poisson = abs(lateral./axial); % Finding the poisson ratio
    average = mean(poisson); % This gives the average
    time = current.time(lower(i):upper(i),1); % Need an x-axis

    figure(i) % Plotting and saving
    plot(time, poisson);
    hold on
    plot([time(1),time(end)],[average,average])
    legend("Instantaneous Poisson Ratio", "Average Poisson Ratio", "Interpreter", "Latex")
    xlabel("Time, $t$", "Interpreter", "latex")
    ylabel("Poisson Ratio, $\nu$", "Interpreter", "latex")
    title(sprintf("Poisson Ratio of Sample %g", i), "Interpreter","latex")
    txt = sprintf('../../figures/poisson_%g.pdf', i);
    saveas(gcf, txt)
    filename = sprintf("../../data/poisson/poisson%g.mat", i);
    save(filename, "average", "poisson")
end
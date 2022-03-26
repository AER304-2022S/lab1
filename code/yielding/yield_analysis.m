yield_strength_gauge = zeros(5, 1);
yield_strength_laser = zeros(5, 1);

for specimen_number = 1:5
    [plot_limit, elastic_limit, stress, strain, laser] = ...
        yield_preprocess(specimen_number);

    fprintf("Currently Analyzing: Specimen %g\n", specimen_number)
    fprintf("Linear fitting from 0 to %g MPa\n", stress(elastic_limit))
    fprintf("Plotting %g / %g total datapoints available\n", plot_limit, length(stress))

    %% Linear Regression (AER336)
    X = [strain.^0 strain];
    X = X(1:elastic_limit, :);

    Y = stress(1:elastic_limit);
    beta = X\Y;

    slope = beta(2);

    sigma = sqrt(1/(elastic_limit-2) * norm(X * beta - Y).^2);
    SIGMA = sigma^2 * inv(X'*X);
    CI_half_width = tinv(0.975, elastic_limit-3) * sqrt(diag(SIGMA));

    fprintf("0.95 CI for slope: [%g, %g] MPa (half-width = %g MPa)\n", ...
            slope - CI_half_width(2), ...
            slope + CI_half_width(2), CI_half_width(2));

    slope_max = slope + CI_half_width(2);
    slope_min = slope - CI_half_width(2);

    %% Offset Strain and 0.2% Yielding

    stress = stress(1:plot_limit);
    strain = strain(1:plot_limit);
    offset_strain = strain-0.002;
    offset_curve = slope * offset_strain;
    offset_curve_min = slope_min * offset_strain;
    offset_curve_max = slope_max * offset_strain;

    [~, idx] = min(abs(offset_curve - stress));
    [~, idmin] = min(abs(offset_curve_min - stress));
    [~, idmax] = min(abs(offset_curve_max - stress));
    fprintf(...
        "Estimated 0.002 offset yield strength (GAUGE) of %g MPa (0.95 CI [%g, %g])\n",...
        stress(idx), stress(idmax), stress(idmin))
    yield_strength_gauge(specimen_number) = stress(idx);

    %% Plot Strain Gauge Results
    figure
    plot(strain, stress, "Linewidth", 2)
    hold on
    axis manual

    XX = xlim();
    xlim([0 XX(2)]);
    YY = ylim();
    ylim([0, YY(2)]);

    plot(strain, slope * strain,...
        strain, offset_curve, "--k",...
        "Linewidth", 1)
    scatter(strain(idx), stress(idx), "green", "Filled")

    yline(stress(idx), "--k", sprintf("%g MPa", stress(idx)),...
        "Linewidth", 1, "LabelHorizontalAlignment", "left",...
        "interpreter", "latex");

    legend("Stress-Strain", "Linear Fit",...
        "0.2\% offset Line", "Yield Point", "Location", "Southeast",...
        "interpreter", "latex")
    grid on;

    title(sprintf("Specimen %g, Yield Strength (MPa), Strain Gauge",...
        specimen_number), "interpreter", "latex")
    xlabel("Engineering Strain, $\epsilon$, (mm/mm)", "Interpreter", "latex")
    ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")

    saveas(gcf, sprintf("../../figures/gaugeyield%d.pdf", specimen_number))

    %% Laser
    laser_warmup = 20;
    laser = laser(laser_warmup:plot_limit);
    laser_strain = (laser - laser(1)) / 50;

    offset_laser = slope * (laser_strain-0.002);
    [~, idlaser] = min(abs(offset_laser - stress(laser_warmup:end)));
    idlaser = idlaser + laser_warmup;
    
    fprintf(...
        "Estimated 0.002 offset yield strength (LASER) of %g MPa \n\n",...
        stress(idlaser))
    yield_strength_laser(specimen_number) = stress(idlaser);

    %% Plot Laser
    figure
    plot(laser_strain, stress(laser_warmup:end), "Linewidth", 2)
    grid on;
    xlabel("Engineering Strain, $\epsilon$, (mm/mm)", "Interpreter", "latex")
    ylabel("Engineering Stress,  $\sigma$, (MPa)", "Interpreter", "latex")
    axis manual
    hold on
    plot(laser_strain, offset_laser, "--k",...
        "Linewidth", 1)
    
    scatter(laser_strain(idlaser-laser_warmup), stress(idlaser), "green", "Filled")
    yline(stress(idlaser), "--k", sprintf("%g MPa", stress(idlaser)),...
        "Linewidth", 1, "LabelHorizontalAlignment", "left",...
        "interpreter", "latex");
    legend("Stress-Strain",...
        "0.2\% offset Line", "Yield Point", "Location", "Southeast",...
        "interpreter", "latex")
    title(sprintf("Specimen %g, Yield Strength (MPa), Laser Extensometer",...
        specimen_number), "interpreter", "latex")
    
    XX = xlim();
    xlim([0 XX(2)]);
    YY = ylim();
    ylim([0, YY(2)]);

    saveas(gcf, sprintf("../../figures/laseryield%d.pdf", specimen_number))
end
table((1:5)', yield_strength_gauge, yield_strength_laser)
input("Press enter to close the plots")
close all


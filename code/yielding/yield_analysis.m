specimen_number = 2;

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
fprintf("Estimated 0.002 offset yield strain of %g MPa (0.95 CI [%g, %g])\n",...
    stress(idx), stress(idmax), stress(idmin))

%% Plot everything
plot(strain, stress, "Linewidth", 2)
hold on
axis manual

XX = xlim();
xlim([0 XX(2)]);
YY = ylim();
ylim([0, YY(2)]);

plot(strain, slope * strain,...
    strain(offset_strain > 0), offset_curve(offset_strain > 0), "--k",...
    "Linewidth", 1)
scatter(strain(idx), stress(idx), "green", "Filled")

y1 = yline(stress(idx), "--k", sprintf("%g MPa", stress(idx)),...
    "Linewidth", 1, "LabelHorizontalAlignment", "left");

legend("Stress-Strain", "Linear Fit",...
    "0.2% offset Line", "Yield Point", "Location", "Southeast")
grid on; grid minor



title(sprintf("Specimen %g",...
    specimen_number))
xlabel("Strain")
ylabel("Engineering Stress (MPa)")
saveas(gcf, sprintf("../../figures/yield%d.pdf", specimen_number))

clear
load ../../data/processed_labview/specimens.mat

lim = [1 1 1 1 1;150 200 200 55 400];
xlimit = 1e-3 * [0.75; 4; 1; 1; 4];

young_mod = zeros(3, 5);

for i = 1:5
    example = specimens{i};

    llim = lim(1, i);
    ulim = lim(2, i);
    
    [beta, sigma, hw] = lin_reg(example.strain_axial(llim:ulim), example.stress(llim:ulim));
    
    figure
    plot(example.strain_axial, example.stress,'.')
    x = linspace(0, xlimit(i), 100);
    grid on
    hold on
    plot(x, beta(2)*x + beta(1))
    hold off
    xlim([0, inf])
    ylim([0 max(example.stress) + 10])
    xlabel("\(\epsilon\)", 'Interpreter','latex')
    ylabel('\(\sigma\)(\(MPa\))', 'Interpreter','latex')
    t = sprintf('Specimen %g Stress vs. Strain curve, Strain Gauge', i);
    title(t, 'Interpreter','latex')
    legend('Experimental Data', "Fitted Young's Modulus", 'Location', 'Best', 'Interpreter', 'latex')
    txt = sprintf('../../figures/youngs_mod_%g.pdf', i);
    saveas(gcf, txt)
    young_mod(1, i) = beta(2)/1e3;
    young_mod(2, i) = sigma/1e3;
    young_mod(3, i) = hw/1e3;
    
end

save('../../data/youngs_mod/youngs_mod.mat', "young_mod")


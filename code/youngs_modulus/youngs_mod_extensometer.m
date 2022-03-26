clear
load ../../data/processed_labview/specimens.mat
dist = 50;
lim = [50 20 100 20 20;150 300 200 200 400];
xlimit = 1e-3 * [0.75; 6; 6; 2; 5];

young_mod = zeros(3, 5);

for i = 1:5
    example = specimens{i};

    llim = lim(1, i);
    ulim = lim(2, i);
    
    [beta, sigma, hw] = lin_reg((example.laser(llim:ulim)-example.laser(llim))/dist, example.stress(llim:ulim));
    
    figure
    plot((example.laser(llim:end) - example.laser(llim))/dist, example.stress(llim:end),'.')
    x = linspace(0, xlimit(i), 100);
    grid on
    hold on
    plot(x, beta(2)*x + beta(1))
    hold off
    xlim([0 inf])
    ylim([0 max(example.stress) + 10])
    xlabel("\(\epsilon\)", 'Interpreter','latex')
    ylabel('\(\sigma\)(\(MPa\))', 'Interpreter','latex')
    t = sprintf('Specimen %g Stress vs. Strain curve, Existensometer', i);
    title(t, 'Interpreter','latex')
    legend('Experimental Data', "Fitted Young's Modulus", 'Location', 'Best', 'Interpreter', 'latex')
    txt = sprintf('../../figures/youngs_mod_extensometer_%g.pdf', i);
    saveas(gcf, txt)
    young_mod(1, i) = beta(2)/1e3;
    young_mod(2, i) = sigma/1e3;
    young_mod(3, i) = hw/1e3;
    
end

save('../../data/youngs_mod/youngs_mod.mat', "young_mod")


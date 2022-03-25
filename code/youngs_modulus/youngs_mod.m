clear
load ../../data/processed_labview/specimens.mat

lim = [1 1 1 1 1;150 200 200 50 400];
xlimit = 1e-3 * [0.5; 4; 1; 1; 4];

for i = 1:5
    example = specimens{i};

    llim = lim(1, i);
    ulim = lim(2, i);
    
    [beta, sigma] = lin_reg(example.strain_axial(llim:ulim), example.stress(llim:ulim));
    E = beta(2);
    
    figure
    plot(example.strain_axial, example.stress,'.')
    x = linspace(0, xlimit(i), 100);
    hold on
    plot(x, beta(2)*x + beta(1))
    hold off
    xlabel("\(\epsilon\)", 'Interpreter','latex')
    ylabel('\(\sigma\)', 'Interpreter','latex')
    title("Specimen 1 Stress vs. Strain curve")
    legend('Experimental Data', "Elastic Regime", 'Location', 'Best')
    txt = sprintf('specimen_%g.pdf', i);
    saveas(gcf, txt)
    filename = sprintf("E%g.mat", i);
    save(filename, "E", "sigma")
end


clear
load ../../data/processed_labview/specimens.mat

example = specimens{4};

llim = 1;
ulim = 50;

beta = lin_reg(example.strain_axial(llim:ulim), example.stress(llim:ulim));

figure
plot(example.strain_axial, example.stress, '.')
x = linspace(0, 1e-3, 100);
hold on
plot(x, beta(2)*x + beta(1))
hold off
xlabel("\(\epsilon\)", 'Interpreter','latex')
ylabel('\(\sigma\)', 'Interpreter','latex')
title("Specimen 4 Stress vs. Strain curve")
legend('Experimental Data', "Elastic Regime, Interpolated", 'Location', 'Best')
saveas(gcf, 'specimen_4.pdf')


E4 = beta(2);

save("E_4.mat","E4")
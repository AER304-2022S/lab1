clear
load ../../data/processed_labview/specimens.mat

example = specimens{5};

llim = 1;
ulim = 400;

beta = lin_reg(example.strain_axial(llim:ulim), example.stress(llim:ulim));

figure
plot(example.strain_axial, example.stress, '.')
x = linspace(0, 4e-3, 100);
hold on
plot(x, beta(2)*x + beta(1))
hold off
xlabel("\(\epsilon\)", 'Interpreter','latex')
ylabel('\(\sigma\)', 'Interpreter','latex')
title("Specimen 5 Stress vs. Strain curve")
legend('Experimental Data', "Elastic Regime, Interpolated", 'Location', 'Best')
saveas(gcf, 'specimen_5.pdf')
E5 = beta(2);

save("E_5.mat","E5")
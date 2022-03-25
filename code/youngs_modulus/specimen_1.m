clear
load ../../data/processed_labview/specimens.mat

example = specimens{1};

llim = 1;
ulim = 150;

beta = lin_reg(example.strain_axial(llim:ulim), example.stress(llim:ulim));
E1 = beta(2);

figure
plot(example.strain_axial, example.stress,'.')
x = linspace(0, 0.5e-3, 100);
hold on
plot(x, beta(2)*x + beta(1))
hold off
xlabel("\(\epsilon\)", 'Interpreter','latex')
ylabel('\(\sigma\)', 'Interpreter','latex')
title("Specimen 1 Stress vs. Strain curve")
legend('Experimental Data', "Elastic Regime, Interpolated", 'Location', 'Best')
saveas(gcf, 'specimen_1.pdf')
save("E_1.mat", "E1")
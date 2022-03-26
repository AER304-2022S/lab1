clear
load ../../data/processed_labview/specimens.mat



example = specimens{1};
ulim = 150;
llim = 50;
dist = 50;

figure
plot((example.laser(llim:ulim)-example.laser(llim))/dist, example.stress(llim:ulim),'.')

[beta, sigma] = lin_reg((example.laser(llim:ulim)-example.laser(llim))/dist, example.stress(llim:ulim));
E = beta(2);

figure
plot((example.laser(llim:end) - example.laser(llim))/dist, example.stress(llim:end),'.')
x = linspace(0, 1e-3, 100);
hold on
plot(x, beta(2)*x + beta(1))
hold off
xlim([0 inf])
ylim([0 max(example.stress)])



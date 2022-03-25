clear
load ../../data/processed_labview/specimens.mat



example = specimens{4};
ulim = 200;
llim = 20;
dist = 50;

figure
plot((example.laser(llim:ulim)-example.laser(llim))/dist, example.stress(llim:ulim))

[beta, sigma] = lin_reg((example.laser(llim:ulim)-example.laser(llim))/dist, example.stress(llim:ulim));
E = beta(2);

figure
plot((example.laser(20:end) - example.laser(llim))/dist, example.stress(20:end))
x = linspace(0, 4e-3, 100);
hold on
plot(x, beta(2)*x + beta(1))
hold off



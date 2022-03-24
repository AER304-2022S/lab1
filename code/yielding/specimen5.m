load ../../data/processed_labview/specimens.mat

stress = specimens{5}.stress;
strain = specimens{5}.strain_axial;

X = [strain.^0 strain];

elastic_limit = 400; % Elastic limit
plot_limit = 700; % Elastic limit

beta = X(1:elastic_limit, :)\stress(1:elastic_limit);

stress = stress(1:plot_limit);
strain = strain(1:plot_limit);

plot(strain, stress,...
    strain, beta(2) * strain,...
    strain, beta(2) * (strain-0.002))
legend("Load-Strain", "Linear Fit", "0.2% offset")
axis tight
grid on
grid minor
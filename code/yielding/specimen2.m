load ../../data/processed_labview/specimens.mat

load_f = specimens{2}.load;
strain = specimens{2}.strain_axial;

X = [strain.^0 strain];

elastic_limit = 350; % Elastic limit
plot_limit = 450; % Elastic limit

beta = X(1:elastic_limit, :)\load_f(1:elastic_limit);

load_f = load_f(1:plot_limit);
strain = strain(1:plot_limit);

plot(strain, load_f,...
    strain, beta(2) * strain,...
    strain, beta(2) * (strain-0.002))
legend("Load-Strain", "Linear Fit", "0.2% offset")
axis tight
grid on
grid minor
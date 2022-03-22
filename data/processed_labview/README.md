# Working with the processed data
1. Load the .mat file into your code. You can do this automatically by doing something along the lines of `load("../../data/processed_labview/specimens.mat")`.
2. The data is stored in the variable `specimens` as a 1x5 cell array. This is a special type of data structure that works sort of like a Python list.
3. Each entry in the cell array corresponds to one specimen. Each specimen is further stored as a MATLAB table.
4. To access the fields in the table, you can do e.g. `specimens{1}.time`, to get the time data for the first specimen.

I have already ordered the strain gauge data such that `.strain_axial` is always consistent. See the preprocessing code file to see how it was done.

## Units
* `time`: seconds
* `load`: N
* `mts_extension`: mm
* `laser`: mm (laser extensometer)
* `strain_axial`: dimensionless
* `strain_poisson`: dimensionless
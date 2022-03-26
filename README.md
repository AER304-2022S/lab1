# AER304 Lab 1
Tensile Testing of Materials

This repository contains data, code and typesetting files related to the work of Group 1 for AER304 Lab 1.

# File Structure
Organization is imperative to a well functioning lab group. The file structure of the repository is as follows:

## At a Glance
* The ***code*** directory contains the scripts to perform analysis on the obtained data.
* The ***data*** directory contains the pressure data captured during the lab.
* The ***latex*** directory contains the files for the latex write up.
* The ***notes*** directory contains pre-lab and data analysis notes.
* The ***reference*** directory contains reference data or materials.

## Detailed Structure
* code
  * preprocessing
  * analysis
  * presentation
* data
  * apparatus_images
  * data_images
  * labview
* notes
  * prelab
* reference

# Running Analysis Code
Requires MATLAB 2019a or later.
1. Navigate the MATLAB editor to `code/preprocessing` and run `preprocess.m`
2. Navigate the MATLAB editor to `code/Poisson's Ratio` and run `poisson_ratio.m`
3. Navigate the MATLAB editor to `code/Ultimate Strength` and run `run_this.m`
4. Navigate the MATLAB editor to `code/yielding` and run `yield_analysis.m`
5. Navigate the MATLAB editor to `code/youngs_modulus` and run `youngs_mod_gauge.m` then `youngs_mod_extensometer.m`

The figures will appear in `figures/.`


% Generate cloud points in different shapes and them compute their Betti
% curves.

clc
clear all
%% Add path tothe Cique-top library
addpath("../clique-top")

% ===================================
%% Parameters
loading = true;
do_betti_analysis = true;

alg_name = 'split';
dens_range = 0.6;
%% Load the matricies with the data
loading = true;
if loading
    load("data/DIST_euc_geom_d2_n88.csv")
    load("data/DIST_euc_geom_d5_n88.csv")
    load("data/DIST_euc_geom_d15_n88.csv")
    load("data/DIST_euc_rand_d2_n88.csv")
    load("data/DIST_euc_rand_d5_n88.csv")
    load("data/DIST_euc_rand_d15_n88.csv")
end
% ===================================
%% Compute and plot Betti curves
size_restric = 88;
if do_betti_analysis
%     compute_and_plot_bettis(DIST_euc_geom_d2_n88, size_restric, alg_name, ...
%                                             dens_range, 'geom_d2');
%     compute_and_plot_bettis(DIST_euc_geom_d5_n88, size_restric, alg_name, ...
%                                             dens_range, 'geom_d5');
%     compute_and_plot_bettis(DIST_euc_geom_d15_n88, size_restric, alg_name, ...
%                                             dens_range, 'geom_d15');
    compute_and_plot_bettis(DIST_euc_rand_d2_n88, size_restric, alg_name, ...
                                            dens_range, 'rand_d2');
	compute_and_plot_bettis(DIST_euc_rand_d5_n88, size_restric, alg_name, ...
                                            dens_range, 'rand_d5');
    compute_and_plot_bettis(DIST_euc_rand_d15_n88, size_restric, alg_name, ...
                                            dens_range, 'rand_d15');
end





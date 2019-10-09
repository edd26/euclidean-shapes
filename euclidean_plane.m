% Generate a point cloud in shape of a filled ball in Euclidean space. Then 
% compute Betti curves for subset of points.

clc
clear all
% ===================================
%% Add path tothe Cique-top library
addpath("../clique-top")
% ===================================
%% Set rand seeed for reproducibility
rng(1234)
% ===================================
%% Parameters
num_of_points = 70;

variance_1 = 0.01;
var_sclae_1 = 3;

plot_shape = true;

distance_measure = 'euclidean';
% distance_measure = 'cosine';

alg_name = 'naive';
dens_range = 0.6;

export_array_to_csv = true;
results_folder = 'results/';
% ===================================
%% Generate plane

X = rand(num_of_points, 1);
Y = rand(num_of_points, 1);
Z = zeros(num_of_points, 1);

dataset_b = [X Y Z];

if plot_shape
    figure;
    scatter3(X,Y,Z)
end

dsit_matrix_p = squareform(pdist(dataset_b, distance_measure));
% ===================================
%% Compute and plot Betti curves
compute_and_plot_cliq_top(dsit_matrix_p, num_of_points, alg_name, dens_range , 'plane');

if export_array_to_csv
    writematrix(dsit_matrix_p,strcat(results_folder,'dist_mat_plane.csv'))
end
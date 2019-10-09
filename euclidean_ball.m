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
outer_radius = 1.;

variance_1 = 0.01;
var_sclae_1 = 3;

plot_spheres = true;

distance_measure = 'euclidean';

alg_name = 'naive';
dens_range = 0.6;

export_cloud_to_csv = true;
export_distances_to_csv= true;
results_folder = 'results/';
% ===================================
%% Generate ball
% generate set of radius values
r = rand(num_of_points, 1);
r = (outer_radius.*r);

angles_1 = (2*pi()).*rand(num_of_points, 1);
angles_2 = (2*pi()).*rand(num_of_points, 1);

X = r.*sin(angles_1).*sin(angles_2);
X = X.* 0.5 + 0.5;
Y = r.*cos(angles_1).*sin(angles_2);
Y = Y.* 0.5 + 0.5;
Z = r.*cos(angles_2);
Z = Z.* 0.5 + 0.5;

% Add noise
X_wnoise = X(:) + sqrt(0*variance_1)*randn(size(X(:)));
Y_wnoise = Y(:) + sqrt(0*variance_1)*randn(size(Y(:)));
Z_wnoise = Z(:) + sqrt(0*variance_1)*randn(size(Z(:)));

% Normalize
X_wnoise_n = X_wnoise ./ max(abs(X_wnoise));
Y_wnoise_n = Y_wnoise ./ max(abs(Y_wnoise));
Z_wnoise_n = Z_wnoise ./ max(abs(Z_wnoise));

dataset_b = [X_wnoise_n Y_wnoise_n Z_wnoise_n];

if plot_spheres
    figure;
    scatter3(X_wnoise_n,Y_wnoise_n,Z_wnoise_n)
end

% dsit_matrix_b = squareform(pdist(dataset_b));
dsit_matrix_b = squareform(pdist(dataset_b, distance_measure));
% ===================================
%% Compute and plot Betti curves
compute_and_plot_cliq_top(dsit_matrix_b, num_of_points, alg_name, dens_range , 'ball');

%% Esport to CSV file
csv_res_folder = strcat(results_folder, 'csv/');
if export_cloud_to_csv
    writematrix(dataset_b,strcat(csv_res_folder,'ball_coord_1', ...
                                                size(dataset_b,1),'.csv'))
end

if export_distances_to_csv
    writematrix(dsit_matrix_b,strcat(csv_res_folder,'dist_mat_ball', ...
                                            size(dsit_matrix_b,1),'.csv'));
end
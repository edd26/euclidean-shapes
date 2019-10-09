% Generate a point cloud in shape of a sphere in Euclidean space. Then 
% compute Betti curves for subset of points from spherical cloud.

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
sphere_1_size = 10;
sphere_2_size = 10;
size_restric= 60;

variance_1 = 0.01;
var_sclae_1=3;
variance_2 = 0.01;
var_sclae_2=3;

plot_spheres = true;

sphr_scaling_factor = 0.1;
sphr_shift_factor = 0.7;

do_betti_analysis = false;
distance_measure = 'euclidean';
alg_name = 'naive';
dens_range = 0.6;

export_cloud_to_csv = true;
export_distances_to_csv = false;
results_folder = 'results/';
% ===================================
%% Sphere 1
[X,Y,Z] = sphere(sphere_1_size);

% Add noise
X_wnoise = X(:) + sqrt(var_sclae_1*variance_1)*randn(size(X(:)));
Y_wnoise = Y(:) + sqrt(var_sclae_1*variance_1)*randn(size(Y(:)));
Z_wnoise = Z(:) + sqrt(variance_1)*randn(size(Z(:)));

% Normalize
X_wnoise_n = X_wnoise ./ max(abs(X_wnoise));
Y_wnoise_n = Y_wnoise ./ max(abs(Y_wnoise));
Z_wnoise_n = Z_wnoise ./ max(abs(Z_wnoise));

dataset_1 = [X_wnoise_n Y_wnoise_n Z_wnoise_n];

% if plot_spheres; figure; scatter3(X_wnoise_n,Y_wnoise_n,Z_wnoise_n); end
% ===================================
%% Sphere 2
[M,N,L] = sphere(sphere_2_size);

% Add noise
M_wnoise = M(:) + sqrt(var_sclae_2*variance_2)*randn(size(M(:)));
N_wnoise = N(:) + sqrt(var_sclae_2*variance_2)*randn(size(N(:)));
L_wnoise = L(:) + sqrt(variance_2)*randn(size(L(:)));

% Normalize
M_wnoise_n = M_wnoise ./ max(abs(M_wnoise));
N_wnoise_n = N_wnoise ./ max(abs(N_wnoise));
L_wnoise_n = L_wnoise ./ max(abs(L_wnoise));

dataset_2 = [M_wnoise_n N_wnoise_n L_wnoise_n];

% if plot_spheres; figure; scatter3(M_wnoise_n,N_wnoise_n,L_wnoise_n); end
% ===================================
%% Reduce the size of sphere 2
dataset_2_r = dataset_2.*sphr_scaling_factor;
dataset = [dataset_1; dataset_2_r];

dataset_perm = dataset(randperm(size(dataset, 1)), :);

distances = pdist(dataset_perm, distance_measure);
dsit_matrix_r = squareform(distances);

if plot_spheres
    figure; 
    scatter3(dataset_perm(1:size_restric,1),...
        dataset_perm(1:size_restric,2), dataset_perm(1:size_restric,3)); 
end

% ===================================
%% Shifted spheres
dataset_2_s = dataset_2 + sphr_shift_factor ;
dataset = [dataset_1; dataset_2_s];
dataset_perm = dataset(randperm(size(dataset, 1)), :);

distances = pdist(dataset_perm, distance_measure);
dsit_matrix_s = squareform(distances);

if plot_spheres
    figure; 
    scatter3(dataset_perm(1:size_restric,1),...
        dataset_perm(1:size_restric,2), dataset_perm(1:size_restric,3)); 
end


% ===================================
%% Compute and plot Betti curves
if do_betti_analysis
    compute_and_plot_cliq_top(dsit_matrix_r, size_restric, alg_name, ...
                                            dens_range, 'double sphere');
    compute_and_plot_cliq_top(dsit_matrix_s, size_restric, alg_name, ...
                                            dens_range, 'shifted sphere');
end

%% Esport to CSV file
csv_res_folder = strcat(results_folder, 'csv/');
if export_cloud_to_csv
    writematrix(dataset_1,strcat(csv_res_folder,'sphr_coord_1_size', ...
                                                size(dataset_1,1),'.csv'))
    writematrix(dataset_2,strcat(csv_res_folder,'sphr_coord_2', ...
                                                size(dataset_2,1),'.csv'))
    writematrix(dataset_2_r,strcat(csv_res_folder, ...
                      'sphr_coord_2_scaled_',size(dataset_2_r,1),'.csv'))
    writematrix(dataset_2_s,strcat(csv_res_folder, ...
                      'sphr_coord_2_shifted_',size(dataset_2_s,1),'.csv'))
end

if export_distances_to_csv
    writematrix(dsit_matrix_r,strcat(csv_res_folder,'dist_mat_sphr_s', ...
                                            size(dsit_matrix_r,1),'.csv'));
    writematrix(dsit_matrix_s,strcat(csv_res_folder,'dist_mat_sphr_r', ...
                                            size(dsit_matrix_s,1),'.csv'));
end
% Generate cloud points in different shapes and them compute their Betti
% curves.

clc
clear all
%% Add path tothe Cique-top library
addpath("../clique-top")

% ===================================
%% Set rand seeed for reproducibility
rng(1234)
% ===================================
%% Parameters

% Shapes
sphere_size_1 = 15;
sphere_size_r = 15;
sphere_size_s = 15;

ball_points = sphere_size_1^2;
outer_radius_b = 1.;
sphr_scaling_factor = 0.1;
sphr_shift_factor = 0.7;

cylinder_points = ball_points;
outer_radius_c = 1.;
inner_radius_c = 0.9;

plane_points = ball_points;

var_1 = 0.01;
var_scale=3;

do_plot = true;

% Distances
distance_measure = 'euclidean';

% Bettis
do_betti_analysis = false;
alg_name = 'split';
dens_range = 0.6;

% Export
export_cloud_to_csv = true;
export_distances_to_csv = true;
results_folder = 'results/';

%% ===================================
% Sphere 1
n_sphr_1='sphr_1';
dataset_1 = euclidean_sphere(sphere_size_1, var_1, var_scale, ...
                        do_plot, 1, 0);
% Sphere shifted
n_sphr_s='sphr_s';
dataset_s =[dataset_1;euclidean_sphere(sphere_size_s, var_1, var_scale, ...
                        do_plot, 1, sphr_shift_factor)];
% Sphere reduced
n_sphr_r='sphr_r';
dataset_r =[dataset_1;euclidean_sphere(sphere_size_r, var_1, var_scale,...
                        do_plot, sphr_scaling_factor, 0)];
% Generate ball
n_ball='ball';
dataset_b = euclidean_ball(ball_points, outer_radius_b, var_1, do_plot);

% Generate cylinder
n_cylin='cylinder';
dataset_c = euclidean_cylinder(cylinder_points, inner_radius_c, ...
                                        outer_radius_c, var_1, do_plot);
% Generate plane
n_plane='plane';
dataset_p = euclidean_plane(plane_points, do_plot);
% ===================================
%% Distances
[dsit_matrix_sphr_1] = get_distance_matrix(dataset_1, distance_measure);
[dsit_matrix_sphr_s] = get_distance_matrix(dataset_s, distance_measure);
[dsit_matrix_sphr_r] = get_distance_matrix(dataset_r, distance_measure);
[dsit_matrix_ball] = get_distance_matrix(dataset_b, distance_measure);
[dsit_matrix_cylinder] = get_distance_matrix(dataset_c, distance_measure);
[dsit_matrix_plane] = get_distance_matrix(dataset_p, distance_measure);

% ===================================
%% Compute and plot Betti curves
if do_betti_analysis
    compute_and_plot_bettis(dsit_matrix_sphr_1, size_restric, alg_name, ...
                                            dens_range, 'single sphere');
    compute_and_plot_bettis(dsit_matrix_sphr_s, size_restric, alg_name, ...
                                            dens_range, 'shifted sphere');
    compute_and_plot_bettis(dsit_matrix_sphr_r, size_restric, alg_name, ...
                                            dens_range, 'shifted sphere');
    compute_and_plot_bettis(dsit_matrix_ball, size_restric, alg_name, ...
                                            dens_range, 'ball');
	compute_and_plot_bettis(dsit_matrix_cylinder, size_restric, alg_name, ...
                                            dens_range, 'cylinder');
    compute_and_plot_bettis(dsit_matrix_plane, size_restric, alg_name, ...
                                            dens_range, 'plane');
end


%% Esport to CSV file
csv_folder = strcat(results_folder, 'csv/');

if export_cloud_to_csv
    suffix = strcat('_coord');
    save_matrix_to_csv(dataset_1,csv_folder, strcat(n_sphr_1, suffix));
    save_matrix_to_csv(dataset_r,csv_folder, strcat(n_sphr_r, suffix));
    save_matrix_to_csv(dataset_s,csv_folder, strcat(n_sphr_s, suffix));
    save_matrix_to_csv(dataset_b,csv_folder, strcat(n_ball, suffix));
    save_matrix_to_csv(dataset_c,csv_folder, strcat(n_cylin, suffix));
    save_matrix_to_csv(dataset_p,csv_folder, strcat(n_plane, suffix));
end

if export_distances_to_csv
    prefix = strcat(distance_measure(1:3),'_dist_mat_');
    save_matrix_to_csv(dsit_matrix_sphr_r,csv_folder, strcat(prefix,n_sphr_r));
    save_matrix_to_csv(dsit_matrix_sphr_s,csv_folder, strcat(prefix,n_sphr_s));
    save_matrix_to_csv(dsit_matrix_ball,csv_folder, strcat(prefix,n_ball));
    save_matrix_to_csv(dsit_matrix_cylinder,csv_folder, ...
                                                    strcat(prefix,n_cylin));
    save_matrix_to_csv(dsit_matrix_plane,csv_folder, strcat(prefix,n_plane));
end

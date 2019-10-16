% Generate symmetric matrix with orderly numbered entnries and them compute
% their Betti curves.

clc
clear all
%% Add path tothe Cique-top library
addpath("../clique-top")

% ===================================
%% Set rand seeed for reproducibility
rng(1234)

% ===================================
%% Hyperparameters
size_restric = 70;

% Distances
distance_measure = 'euclidean';

% Bettis
do_betti_analysis = true;
alg_name = 'split';
dens_range = 0.6;

% Export
export_matrix_to_csv = true;
results_folder = 'results/';

% ===================================
%% Generate matrix

matrix_col_num = size_restric; 
matrix_row_num = matrix_col_num;

numbered_matrix = zeros(matrix_row_num, matrix_col_num);
set_of_numbers = 1:1:((matrix_col_num*(matrix_col_num-1))/2);
set_of_numbers_rand = set_of_numbers(randperm(length(set_of_numbers)));

iterator = 1;
for row = 1:matrix_row_num
    for column = row+1:matrix_col_num
        numbered_matrix(row, column) = set_of_numbers_rand(iterator);
        numbered_matrix(column, row) = set_of_numbers_rand(iterator);
        iterator = iterator + 1; 
    end
end

% ===================================
%% Compute and plot Betti curves
if do_betti_analysis
    compute_and_plot_bettis(numbered_matrix, size_restric, alg_name, ...
                                            dens_range, 'numbered matrix');
end

%% Esport to CSV file
csv_folder = strcat(results_folder, 'csv/');

if export_matrix_to_csv
    save_matrix_to_csv(numbered_matrix,csv_folder, 'numbered_matrix');
end
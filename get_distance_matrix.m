function [dsit_matrix] = get_distance_matrix(dataset, distance_measure)
% Compute distances between points stored in 'dataset'. Every column
% represents cordinate and every row represents a data point.
% 'distance_measure' determines type of distance measure used.
%
% Returns square matrix with interpoint distances.

dataset_perm = dataset(randperm(size(dataset, 1)), :);
 
distances = pdist(dataset_perm, distance_measure);
dsit_matrix = squareform(distances);
end


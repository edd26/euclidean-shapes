function [dsit_matrix] = get_distance_matrix(dataset, distance_measure, ...
                                                            restriction)
% Compute distances between points stored in 'dataset'. Every column
% represents cordinate and every row represents a data point.
% 'distance_measure' determines type of distance measure used.
%
% Returns square matrix with interpoint distances.

dataset_perm = dataset(randperm(size(dataset, 1)), :);

if restriction < size(dataset_perm, 1)
    dataset_perm = dataset_perm(1:restriction, :);
end
distances = pdist(dataset_perm, distance_measure);
dsit_matrix = squareform(distances);
end


function [bettiCurves, edgeDensities, figure_handle] = ...
            compute_and_plot_bettis(result, matrix_size, alghorithm, ...
                                              MaxEdgeDens, dataset_name)
% Apply 'compute_clique_topology' to the 'results' symmetric matrix using
% 'alghorithm'. Also, the time of computations is displayed after obtaining
% results of topological analysis. The results are ploted afterwards and
% the handler to the figure is returned as 'figure_handle'.
% 
% 'matrix_size': number of elements taken from 'result' in computaion of 
%       cliqe topology; values below 1 or exceeding results matrix will
%       cause setting the value to maximal avaliable size.
% 'MaxEdgeDensity': maximum graph density to include in the
%	order complex in range (0, 1] ;
% 'dataset_name': name of the data used; this value is displayed on the
%  plot of the Betti curves.

if matrix_size > size(result,1)
    fprintf("Given number of elements exceeds input matrix size.\n")
    fprintf("Using all elements instead.\n")
    matrix_size = size(result,1)
elseif (matrix_size < 1)
    fprintf("Given number of elements is below 1.\n")
    fprintf("Using all elements instead.\n")
    matrix_size = size(result,1)
end
tic
[bettiCurves, edgeDensities, ~, ~] =  compute_clique_topology( ...
                         result(1:matrix_size, 1:matrix_size), ...
                                       'Algorithm', alghorithm, ...
                                 'MaxEdgeDensity', MaxEdgeDens);
toc
figure_handle = plot_bettis(edgeDensities,bettiCurves,dataset_name, ...
                                                alghorithm, matrix_size);
end


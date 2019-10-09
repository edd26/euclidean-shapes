function [bettiCurves, edgeDensities] = compute_cliq_top(result, ...
                                matrix_size, alghorithm, MaxEdgeDens)
% Apply 'compute_clique_topology' to the 'results' symmetric matrix using
% 'alghorithm'. Also, the time of computations is displayed after obtaining
% results of topological analysis.
% 
% 'matrix_size': number of elements taken from 'result' in computaion of 
%       cliqe topology; values below 1 or exceeding results matrix will
%       cause setting the value to maximal avaliable size.
% 'MaxEdgeDensity': maximum graph density to include in the
%	order complex in range (0, 1] ;

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
     result(1:matrix_size, 1:matrix_size), 'Algorithm', alghorithm, ...
                    'MaxEdgeDensity', MaxEdgeDens, 'ComputeBetti0', true);
toc

end


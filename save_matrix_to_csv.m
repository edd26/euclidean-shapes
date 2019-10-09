function save_matrix_to_csv(matrix,path, file_name)
% Wrapper to 'writematrix' function. Writes 'matrix' to 'filename'.csv file
% in 'path' folder. Appends the matrix size to the given file name.

writematrix(matrix,strcat(path,file_name, '_size', ...
                                        num2str(size(matrix,1)),'.csv'));
end


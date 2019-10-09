function dataset_1 = euclidean_sphere(points_number, var_1, var_scale, ...
                        do_plot, sphr_scaling_factor, sphr_shift_factor)
% Return point cloud in shape of a sphere in Euclidean space.

    [X,Y,Z] = sphere(points_number);

    % Add noise
    X_wnoise = X(:) + sqrt(var_scale*var_1)*randn(size(X(:)));
    Y_wnoise = Y(:) + sqrt(var_scale*var_1)*randn(size(Y(:)));
    Z_wnoise = Z(:) + sqrt(var_1)*randn(size(Z(:)));

    % Normalize
    X_wnoise_n = X_wnoise ./ max(abs(X_wnoise));
    Y_wnoise_n = Y_wnoise ./ max(abs(Y_wnoise));
    Z_wnoise_n = Z_wnoise ./ max(abs(Z_wnoise));

    dataset_1 = [X_wnoise_n Y_wnoise_n Z_wnoise_n];

    if do_plot
        figure; 
        scatter3(dataset_1(:,1),...
            dataset_1(:,2), dataset_1(:,3)); 
    end
end
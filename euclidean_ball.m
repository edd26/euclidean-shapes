function dataset_1 = euclidean_ball(num_of_points, outer_radius, var_1, ...
                                                                do_plot)
% Generate a point cloud in shape of a filled ball in Euclidean space. 

% Generate ball
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
    X_wnoise = X(:) + sqrt(0*var_1)*randn(size(X(:)));
    Y_wnoise = Y(:) + sqrt(0*var_1)*randn(size(Y(:)));
    Z_wnoise = Z(:) + sqrt(0*var_1)*randn(size(Z(:)));

    % Normalize
    X_wnoise_n = X_wnoise ./ max(abs(X_wnoise));
    Y_wnoise_n = Y_wnoise ./ max(abs(Y_wnoise));
    Z_wnoise_n = Z_wnoise ./ max(abs(Z_wnoise));

    dataset_1 = [X_wnoise_n Y_wnoise_n Z_wnoise_n];

    if do_plot
        figure;
        scatter3(X_wnoise_n,Y_wnoise_n,Z_wnoise_n)
    end
end
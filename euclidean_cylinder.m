function dataset_c = euclidean_cylinder(num_of_points, inner_radius, ...
                                            outer_radius, var_1, do_plot)
% Generate a point cloud in shape of a cylinder in Euclidean space. 

    % Generate cylinder
    % generate set of radius values
    r = rand(num_of_points, 1);
    r = (r.*(outer_radius-inner_radius)) + inner_radius;

    angles = (2*pi()).*rand(num_of_points, 1);

    X = r.*sin(angles);
    X = X.* 0.5 + 0.5;
    Y = r.*cos(angles);
    Y = Y.* 0.5 + 0.5;

    % Generate set of z values
    Z = rand(num_of_points, 1);

    % Add noise
    X_wnoise = X(:) + sqrt(var_1)*randn(size(X(:)));
    Y_wnoise = Y(:) + sqrt(var_1)*randn(size(Y(:)));
    Z_wnoise = Z(:) + sqrt(var_1)*randn(size(Z(:)));

    % Normalize
    X_wnoise_n = X_wnoise ./ max(abs(X_wnoise));
    Y_wnoise_n = Y_wnoise ./ max(abs(Y_wnoise));
    Z_wnoise_n = Z_wnoise ./ max(abs(Z_wnoise));

    dataset_c = [X_wnoise_n Y_wnoise_n Z_wnoise_n];

    if do_plot
        figure;
        scatter3(X_wnoise_n,Y_wnoise_n,Z_wnoise_n)
    end
end



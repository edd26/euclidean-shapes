function dataset_p = euclidean_plane(num_of_points, do_plot)
% Generate a point cloud in shape of a filled ball in Euclidean space.

% Generate plane
    X = rand(num_of_points, 1);
    Y = rand(num_of_points, 1);
    Z = zeros(num_of_points, 1);

    dataset_p = [X Y Z];

    if do_plot
        figure;
        scatter3(X,Y,Z)
    end
end
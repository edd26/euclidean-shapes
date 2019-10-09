function comp_and_plot_euler_char(result, endings, algorithm,...
                                                max_edge_dens, data_name)
% Computes Euler characteristic for set of Betti curves computed for the
% given input symmetric matrix
[bet_curves, edge_dens] = compute_cliq_top(result, ...
                endings, algorithm , max_edge_dens);
[euler_ent] = euler_entropy(bet_curves);
plot_entropy_and_bettis(euler_ent, bet_curves, edge_dens, data_name, ...
                                            algorithm, endings)
end


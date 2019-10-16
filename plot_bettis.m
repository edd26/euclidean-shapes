function figure_handle = plot_bettis(edgeDensities,bettiCurves,...
                        dataset_name, algorihm_name, matrix_size)
% Function for plotting betti curves obtained from clique-top library.
% Uses 'edgeDensities' variable for horizontal axis values and 
% 'bettiCurves' variable for plotting curves.

figure_handle = figure;
plot(edgeDensities, bettiCurves(:,1), '--', 'Color', [0.929 0.694 0.125]);
hold on
try
    plot(edgeDensities, bettiCurves(:,2), 'r--')
catch error
    fprintf("Betti number 3 was not printed- it was not computed.\n")
end
try
    plot(edgeDensities, bettiCurves(:,3), 'b--')
catch error
    fprintf("Betti number 3 was not printed- it was not computed\n")
end

title_text = strcat("Betti curves for ", dataset_name," dataset, ",...
            algorihm_name, " alg., matrix size=",num2str(matrix_size));
title(title_text)
xlabel("Edge density")
ylabel("Betti values (number of cycles)")
legend("\beta_1","\beta_2","\beta_3", 'Location','northwest')
hold off
end


function plot_entropy_and_bettis(euler_ent, bettiCurves, ...
                 edgeDensities, dataset_name, alghorithm, matrix_size)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

figure
plot(edgeDensities, bettiCurves(:,1), '--', 'Color', [0.4660 0.6740 0.1880]);
hold on
plot(edgeDensities, bettiCurves(:,2), '--', 'Color', [0.929 0.694 0.125]);
plot(edgeDensities, bettiCurves(:,3), 'r--')
plot(edgeDensities, bettiCurves(:,4), 'b--')
hold off


xlabel("Edge density")
ylabel("Betti values (number of cycles)")

yyaxis right
plot(edgeDensities, euler_ent, 'Color', [0.4940 0.1840 0.5560]);
ylabel("Euler entropy ln|\Xi|")

title_text = strcat("Betti curves for ", dataset_name," dataset, ",...
            alghorithm, " alg., matrix size=",num2str(matrix_size));
title(title_text)
legend("\beta_0", "\beta_1","\beta_2","\beta_3", "Euler entropy")

end


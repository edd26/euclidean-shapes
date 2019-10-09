function [result] = comp_corr_matrix(dataset)
% Copmute the crosscorrelation of the features value contained in columns
% of 'dataset' using samples contained in rows of the 'dataset' according
% to the formula preseted in "Hyperbolic geometry of the olfactory space"
% by Y.Zhou et al. Return symmetric matrix with crosscorrelation of the
% features of the dataset.
% 
% 'dataset': every row represents a sample which is described with same
%   feature values present in columns of the variable.
[samples, features_num] = size(dataset);
result = zeros(features_num, features_num);

% Remove mean value of a feature from all the features
mean_features = mean(dataset);
dataset_reduced = dataset - ones(samples,1) * mean_features;

for row= 1:features_num
    denom1 = sqrt(sum(dataset_reduced(:,row).^2));
    for col =1:features_num
        nomminator = dataset_reduced(:,row)' * ... 
                                    dataset_reduced(:,col);
        denom2 = sqrt(sum(dataset_reduced(:,col).^2));
        result(row, col) = nomminator/(denom1*denom2);
    end
end
end


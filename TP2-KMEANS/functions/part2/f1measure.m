function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(cluster_labels,2);
nClusters = max(cluster_labels);
nClasses = max(class_labels);
N = zeros(nClusters , nClasses);


for i = 1:M
    N(cluster_labels(i),class_labels(i)) =  N(cluster_labels(i),class_labels(i))  +1 ;
    
end

R = N ./ sum(N,1);

P = N ./ sum(N,2);

F1 = (2*R.*P)./(R+P);

F1(isnan(F1)) = 0;


v = sum(N,1);
F1_overall= zeros;

for i = 1:length(v)
    F1_overall = F1_overall + (v(1,i)/M)*max(F1(:,i),[],1);
end






end

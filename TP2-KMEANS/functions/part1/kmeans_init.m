function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (D x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N      

N = size(X,1);
M = size(X,2);
Mu = zeros(N,k);

if strcmp(init,'sample')
    ind = randsample(M,k);
    Mu = X(:,ind);
end



if strcmp(init, 'range')

    minX = min(X,[],2);
    maxX = max(X,[],2);
    Mu = minX + rand(N, k) .* (maxX - minX);


end



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









end
function [XNew] = sample_from_gmm(gmm, nbSamples)
%SAMPLE_FROM_GMM Generate new samples from a learned GMM
%
%   input------------------------------------------------------------------
%       o gmm    : (structure), Contains the following fields
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o nbSamples    : (int) Number of samples to generate.
%   output ----------------------------------------------------------------
%       o XNew  :  (N x nbSamples), Newly generated set of samples.
%%
N = size(gmm.Mu,1);

Xnew = zeros(N,nbSamples);

    for i = 1:nbSamples
        k = randsrc(1, 1, [1:length(gmm.Priors); gmm.Priors]);
        XNew(:, i) = mvnrnd(gmm.Mu(:, k)', gmm.Sigma(:, :, k));
    end



end


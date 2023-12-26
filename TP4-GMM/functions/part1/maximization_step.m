function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

N = size(X,1);
M = size(X,2);
K = size(Pk_x,1);
Priors = zeros(1,K);
den = zeros(1,K);
num = zeros(N,K);
numn = zeros(N,N,K);
correction = 1e-5;
ID3D = repmat(eye(N)*correction, [1, 1, K]);


for k = 1 : K
      de = 0;
      nu = 0;
    for i = 1 : M
        de = de + Pk_x(k,i);
        nu = nu + Pk_x(k,i)*X(:,i);
    end
        den(k) = de;
        num(:,k) = nu;
        Priors(k) = (1/M) * de;
end

Mu = num./den;


if (params.cov_type == "full" || params.cov_type == "diag" )

for k = 1 : K
      nu = 0;
    for i = 1 : M
        nu = nu + Pk_x(k,i)*(X(:,i)-Mu(:,k))*(X(:,i)-Mu(:,k))';
    end
        numn(:,:,k) = nu;
end

if (params.cov_type == "full")
    Sigma = bsxfun(@rdivide, numn, reshape(den, [1, 1, K]));
    Sigma = ID3D + Sigma;
else
    Sigma = diag(diag(bsxfun(@rdivide, numn, reshape(den, [1, 1, K]))));
    Sigma = ID3D + Sigma; 
end
end


if (params.cov_type == "iso")
    den = N *den;
for k = 1 : K
      nu = 0;
    for i = 1 : M
        nu = nu + Pk_x(k,i)*norm(X(:,i)-Mu(:,k)).^2;
    end
        numn(:,:,k) = nu*eye(N);
end

Sigma = bsxfun(@rdivide, numn, reshape(den, [1, 1, K]));
Sigma = ID3D + Sigma;

end


end


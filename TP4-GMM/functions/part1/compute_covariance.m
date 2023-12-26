function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%
N = size(X,1);
M = size(X,2);
Sigma = zeros(N);

if (type == "full")
    X_hat = X-X_bar;
    Sigma = (1/(M-1))*(X_hat*X_hat');
end

if (type == "diag")
    X_hat = X-X_bar;
    Sigma_ = (1/(M-1))*(X_hat*X_hat');
    Sigma = diag(diag(Sigma_));
end

if (type == "iso")
    Somma = 0;
    for i = 1 : M
        Somma = Somma + norm(X(:,i)-X_bar).^2; 
    end
    Sigma_iso = Somma / (N*M);
    Sigma = Sigma_iso * eye(N);
end


end


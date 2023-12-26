function [metrics] = cross_validation_gmr( X, y, F_fold, valid_ratio, k_range, params )
%CROSS_VALIDATION_GMR Implementation of F-fold cross-validation for regression algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (P x M) array representing the y vector assigned to
%                           each datapoints
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Testing Ratio.
%       o k_range   : (1 x K), Range of k-values to evaluate
%       o params    : parameter strcuture of the GMM
%
%   output ----------------------------------------------------------------
%       o metrics : (structure) contains the following elements:
%           - mean_MSE   : (1 x K), Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_NMSE  : (1 x K), Normalized Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_R2    : (1 x K), Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - mean_AIC   : (1 x K), Mean AIC Scores computed for each value of k averaged over the number of folds.
%           - mean_BIC   : (1 x K), Mean BIC Scores computed for each value of k averaged over the number of folds.
%           - std_MSE    : (1 x K), Standard Deviation of Mean Squared Error computed for each value of k.
%           - std_NMSE   : (1 x K), Standard Deviation of Normalized Mean Squared Error computed for each value of k.
%           - std_R2     : (1 x K), Standard Deviation of Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - std_AIC    : (1 x K), Standard Deviation of AIC Scores computed for each value of k averaged over the number of folds.
%           - std_BIC    : (1 x K), Standard Deviation of BIC Scores computed for each value of k averaged over the number of folds.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

in = 1:size(X,1);
out = size(X,1)+1:(size(X,1)+size(y,1));



for i =1:length(k_range)

        MSEsum=zeros;
        NMSEsum=zeros;
        R2sum = zeros;
        AICsum = zeros;
        BICsum = zeros;
        
        MSE_cuml = [];
        NMSE_cuml = [];
        R2_cuml = [];
        AIC_cuml = [];
        BIC_cuml = [];

    for j = 1 : F_fold
        
        % ASK for valid_ratio 1-valid_ratio or valid ratio

        [X_train, y_train, X_test, y_test] = split_regression_data( X, y, valid_ratio);

        params.k = k_range(i);

        [  Priors, Mu, Sigma, ~ ] = gmmEM([X_train;y_train], params);

        [y_est, ~] = gmr(Priors, Mu, Sigma, X_test, in, out);

        [MSE, NMSE, Rsquared] = regression_metrics( y_est, y_test );

        [AIC, BIC] =  gmm_metrics([X_train;y_train] , Priors, Mu, Sigma, params.cov_type);

        MSE_cuml = cat(1,MSE_cuml,MSE);
        NMSE_cuml = cat(1, NMSE_cuml,NMSE);
        R2_cuml = cat(1,R2_cuml,Rsquared);
        AIC_cuml = cat(1,AIC_cuml,AIC);
        BIC_cuml = cat(1,BIC_cuml,BIC);

        MSEsum = MSEsum + MSE;
        NMSEsum = NMSEsum + NMSE;
        R2sum = R2sum + Rsquared;
        AICsum = AICsum + AIC;
        BICsum = BICsum + BIC;

    end

mean_MSE(i) = MSEsum/F_fold;

mean_NMSE(i) = NMSEsum/F_fold;

mean_R2(i) = R2sum/F_fold;

mean_AIC(i) = AICsum/F_fold;

mean_BIC(i) = BICsum/F_fold;


std_MSE(i) = std(MSE_cuml,0,1);

std_NMSE(i) = std(NMSE_cuml,0,1);

std_R2(i) = std(R2_cuml,0,1);

std_AIC(i) = std(AIC_cuml,0,1);

std_BIC(i) = std(BIC_cuml,0,1);

end
metrics.mean_MSE = mean_MSE;

metrics.mean_NMSE = mean_NMSE;

metrics.mean_R2 = mean_R2;

metrics.mean_AIC = mean_AIC;

metrics.mean_BIC = mean_BIC;


metrics.std_MSE = std_MSE;

metrics.std_NMSE = std_NMSE;

metrics.std_R2 = std_R2;

metrics.std_AIC = std_AIC;

metrics.std_BIC = std_BIC;






end


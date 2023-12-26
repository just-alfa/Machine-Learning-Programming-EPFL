function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RSS_curve = zeros(K_range);
% AIC_curve = zeros(K_range);
% BIC_curve = zeros(K_range);

for  k = 1: size(K_range,2)
    for i = 1:repeats
        [labels, Mu, ~, ~] =  kmeans(X,k,init,type,MaxIter,0);
        [RSS, AIC, BIC] =  compute_metrics(X, labels, Mu);
        RSS_curve_(i) = RSS;
        AIC_curve_(i) = AIC;
        BIC_curve_(i) = BIC;
    end
RSS_curve(k)=mean(RSS_curve_);
AIC_curve(k)=mean(AIC_curve_);
BIC_curve(k)=mean(BIC_curve_);
end


    

end
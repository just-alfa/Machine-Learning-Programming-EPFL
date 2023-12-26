function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = size(yest,2);

MSE = 0;
VARY = 0;
radN = 0;
D1 = 0;
D2 = 0;

for i = 1 : M
    MSE = MSE + (norm(yest(:,i)-y(:,i))).^2;
    VARY = VARY + (norm(y(:,i) - mean(y,2))).^2;
    radN = radN + (y(:,i) - mean(y,2)) .* ((yest(:,i) - mean(yest,2)));
    D1 = D1 + (norm(y(:,i) - mean(y,2))).^2;
    D2 = D2 + (norm(yest(:,i) - mean(yest,2))).^2;
end

MSE = 1/M * MSE;
VARY = (1/(M-1)) * VARY;
NMSE = MSE./VARY;
Rsquared = ((norm(radN)).^2)./(D1*D2);
Rsquared(isnan(Rsquared)) = 0;
NMSE(isnan(NMSE)) = 0;

end


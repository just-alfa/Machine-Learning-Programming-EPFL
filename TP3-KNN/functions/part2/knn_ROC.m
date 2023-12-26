function [ TP_rate, FP_rate ] = knn_ROC( X_train, y_train, X_test, y_test,  params )
%KNN_ROC Implementation of ROC curve for kNN algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_test   : (1 x M_test), a vector with labels y \in {1,2} corresponding to X_test.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and k_range)
%
%   output ----------------------------------------------------------------

%       o TP_rate  : (1 x K), True Positive Rate computed for each value of k.
%       o FP_rate  : (1 x K), False Positive Rate computed for each value of k.
%        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TP_rate = zeros(1,length(params.k_range));
FP_rate = zeros(1,length(params.k_range));

for j=1:length(params.k_range)
    params.k = params.k_range(j); 
    y_est =  knn(X_train,  y_train, X_test,params);
TP = 0;
FN = 0;
FP = 0;
TN = 0;
M = size(y_est,2);

for i = 1:M
    if ((y_test(i) == 1) && (y_est(i) == 1))
        TP = TP + 1;
    end



    if ((y_test(i) == 2) && (y_est(i) == 2))
        TN = TN + 1;
    end



    if ((y_test(i) == 1) && (y_est(i)==2))
        FN = FN + 1;
    end


    if ((y_test(i) == 2) && (y_est(i)==1))
        FP = FP + 1;
    end
end

    TP_r = (TP)/(TP+FN);
    FP_r = (FP)/(FP+TN); 
    TP_rate(j) = TP_r; 
    FP_rate(j) = FP_r;

end





end
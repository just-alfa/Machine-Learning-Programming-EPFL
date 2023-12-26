function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% distances
N = size(X_train, 2); 
M = size(X_test, 2); 
d = zeros(M,N);

for i=1:M
    for j = 1:N
        d(i,j) = compute_distance(X_test(:,i),X_train(:,j), params);
    end
end

% each rows of d is the distance between a training point and all the
% testing points

%d_sorted = zeros(M,N);
ind = zeros(M,N);
[~, ind] = sort(d,2);
k = params.k;
ind = ind(:,1:k);
%ind = ind(1:k,:);



y_est= zeros(1, M);
  %disp('test')
  for i = 1:M
      %disp(i);
      yknn(i,:) =  y_train(ind(i,:));
      y_est(i) = mode(yknn(i, :));
  end

end
  

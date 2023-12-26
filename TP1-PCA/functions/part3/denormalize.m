function [Xinversed] = denormalize(X, param1, param2, normalization)
%DENORMALIZE Denormalize the data wrt to the normalization technique passed in
%parameter and param1 and param2 calculated during the normalization step
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o X : (N x M), normalized data of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : first parameter of the normalization 
%       o param2 : second parameter of the normalization
%
%   output ----------------------------------------------------------------
%
%       o Xinversed : (N x M), the denormalized data

if strcmp(normalization,'minmax') && nargin == 4
    xmin = param1;
    xmax = param2;
    Xinversed = X.*(xmax -xmin) +xmin;
end

if strcmp(normalization,'zscore') && nargin == 4
    mu = param1;
    stdx = param2;
    Xinversed = X.*stdx + mu;
end

if strcmp(normalization,'none')
    Xinversed = X;
end

if strcmp(normalization,'minmax') && nargin ~= 4
    xmin = min(data,[],2);
    xmax = max(data,[],2);
    Xinversed = X.*(xmax -xmin) +xmin;
end

if strcmp(normalization,'zscore') && nargin ~= 4
    mu = mean(data,2);
    stdx = std(data,0,2);
    Xinversed = X.*stdx + mu;
end

end


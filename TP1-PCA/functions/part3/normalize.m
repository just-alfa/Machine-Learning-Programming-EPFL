function [X, p1, p2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization


if strcmp(normalization,'minmax') && nargin == 4
    xmin = param1;
    xmax = param2;
    X = (data - xmin) ./ (xmax-xmin);
    p1 = xmin;
    p2 = xmax;
end

if strcmp(normalization,'zscore') && nargin == 4
    mu = param1;
    stdx = param2;
    X = (data - mu) ./stdx;
    p1 = mu;
    p2 = stdx;
end

if strcmp(normalization,'none')
    X = data;
    p1 = 0;
    p2 = 0;
end

if strcmp(normalization,'minmax') && nargin ~= 4
    xmin = min(data,[],2);
    xmax = max(data,[],2);
    X = (data - xmin) ./ (xmax-xmin);
    p1 = xmin;
    p2 = xmax;
end

if strcmp(normalization,'zscore') && nargin ~= 4
    mu = mean(data,2);
    stdx = std(data,0,2);
    X = (data - mu) ./stdx;
    p1 = mu;
    p2 = stdx;

end

end


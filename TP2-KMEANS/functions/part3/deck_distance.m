function [dist] = deck_distance(deck, Mu, type)
%DECK_DISTANCE Calculate the distance between a partially filled deck and
%the centroides
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N x 1) a partially filled deck
%       o Mu : (N x K) Value of the centroids
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o dist : K X 1 the distance to the k centroids
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(Mu,1);

ind = [];
for i = 1 : N
    if (deck(i)==0)
        ind = cat(1,ind,i);
    end
end


deck_clean = deck(deck ~= 0);


Mu_new = Mu;
Mu_new(ind, :) = [];

dist =  distance_to_centroids(deck_clean, Mu_new, type);

end

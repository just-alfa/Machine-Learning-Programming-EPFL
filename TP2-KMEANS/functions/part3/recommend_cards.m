function [cards] = recommend_cards(deck, Mu, type)
%RECOMMAND_CARDS Recommands a card for the deck in input based on the
%centroid of the clusters
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N, 1) a deck of card
%       o Mu : (M x k) the centroids of the k clusters
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o cards : a set of cards recommanded to add to this deck
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d =  deck_distance(deck, Mu, type);
M = size(Mu,1);
Mu_new = [];
ind_list = [];
closest_kluster=find(d == min(d),1,'first');

for i = 1: M
    if not( Mu(i,closest_kluster) == 0)
        Mu_new = cat(1,Mu_new,Mu(i,closest_kluster));
        ind_list = cat(1,ind_list,i);
    end
end

mat = cat(2,ind_list,Mu_new);
ind_ord = sortrows(mat,-2);
ind_ord_def = ind_ord(:,1);
cards = ind_ord_def;
cards = cards';

end


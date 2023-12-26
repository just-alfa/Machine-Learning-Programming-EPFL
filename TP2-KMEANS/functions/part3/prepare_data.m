function [X, unique_cards] = prepare_data(data)
%PREPARE_DATA Convert the list of cards and deck to a matrix representation
%             where each row is a unique card and each column a deck. The
%             value in each cell is the number of time the card appears in
%             the deck
%
%   input -----------------------------------------------------------------
%   
%       o data   : (60, M) a dataset of M decks. A deck contains 60 non
%       necesserally unique cards
%
%   output ----------------------------------------------------------------
%
%       o X  : (N x M) matrix representation of the frequency of appearance
%       of unique cards in the decks whit N the number of unique cards in
%       the dataset and M the number of decks
%       o unique_cards : {N x 1} the set of unique card names as a cell
%       array
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = size(data,2);
L = size(data,1); 
N = 0;
unique_cards = {};
for i = 1 : L
    for j = 1 : M
        if not(ismember(data(i,j),unique_cards(:,:)))
            unique_cards = cat(2,unique_cards,data(i,j));
            N = N+1;
        end
    end
end
unique_cards = sort(unique_cards);
unique_cards=unique_cards';



X = zeros(N,M);

for n = 1 : N
    arr = 0;
    for j = 1 : M
        arr = (ismember(data(:,j),unique_cards(n,1)));
        X(n,j) = sum(arr);
    end
end


end


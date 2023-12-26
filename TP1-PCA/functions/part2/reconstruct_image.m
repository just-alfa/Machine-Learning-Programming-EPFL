function [rimg] = reconstruct_image(cimg, ApList, muList)
%RECONSTRUCT_IMAGE Reconstruct the image given the compressed image, the
%projection matrices and mean vectors of each channels
%
%   input -----------------------------------------------------------------
%   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o rimg : The reconstructed image

rimgR = reconstruct_pca(cimg(:,:,1), ApList(:,:,1), muList(:,1));
rimgG = reconstruct_pca(cimg(:,:,2), ApList(:,:,2), muList(:,2));
rimgB = reconstruct_pca(cimg(:,:,3), ApList(:,:,3), muList(:,3));
rimg = cat(3,rimgR,rimgG,rimgB);

end


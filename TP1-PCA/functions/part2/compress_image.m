function [cimg, ApList, muList] = compress_image(img, p)
%COMPRESS_IMAGE Compress the image by applying the PCA over each channels 
% independently
%
%   input -----------------------------------------------------------------
%   
%       o img : (height x width x 3), an image of size height x width over RGB channels
%       o p : The number of components to keep during projection 
%
%   output ----------------------------------------------------------------
%
%       o cimg : (p x width x 3) The projection of the image on the eigenvectors
%       o ApList : (p x height x 3) The projection matrices for each channels
%       o muList : (height x 3) The mean vector for each channels
imexR = img(:,:,1);
imexG = img(:,:,2);
imexB = img(:,:,3);
[MuR, ~, EigenVectorsR, ~] = compute_pca(imexR);
[MuG, ~, EigenVectorsG, ~] = compute_pca(imexG);
[MuB, ~, EigenVectorsB, ~] = compute_pca(imexB);
[YprojR, ApR] = project_pca(imexR, MuR, EigenVectorsR, p);
[YprojG, ApG] = project_pca(imexG, MuG, EigenVectorsG, p);
[YprojB, ApB] = project_pca(imexB, MuB, EigenVectorsB, p);
ApList = cat (3, ApR, ApG, ApB);
cimg = cat(3,YprojR,YprojG,YprojB);
muList = [MuR, MuG, MuB];
end


function [ImgNormalized,gridxyROIRange] = funNormalizeImg(Img,gridxyROIRange)
%FUNCTION [ImgNormalized,gridxyROIRange] = funNormalizeImg(Img,gridxyROIRange)
%
% This function is to normalize images following the formula: 
%       Normalized(Img) = (Img-Mean(Img))/sqrt(Std(Img))
% Normalized image grayscale value is between [-1,1]
%
%   INPUT: Img              Loaded DIC raw images
%          gridxyROIRange   Chosen DIC region of interest (ROI)
%
%   OUTPUT: ImgNormalized   Normalized DIC images
%           gridxyROIRange  Updated ROI range in case the initial ROI is
%                           out of the image domain
%
% --------------------------------
% Author: Jin Yang
% Contact and support: jyang526@wisc.edu  -or-  aldicdvc@gmail.com
% Last updated: 02/2020.
% ==============================================

%%
gridxROIRange = gridxyROIRange.gridx; gridyROIRange = gridxyROIRange.gridy; 

% ======= To garantuee ROI value is within image boundary =======
if gridxROIRange(1)< 1; gridxROIRange(1) = 1; end
if gridxROIRange(2)>size(Img{1},1); gridxROIRange(2) = size(Img{1},1);end
if gridyROIRange(1)< 1; gridyROIRange(1) = 1; end
if gridyROIRange(2)>size(Img{1},2); gridyROIRange(2) = size(Img{1},2);end 

gridxyROIRange.gridx = gridxROIRange; gridxyROIRange.gridy = gridyROIRange;
 
% ============== Normalize or compress images ==============
% ============== Normalize f and g ==============
ImgNormalized = cell(size(Img));

for i = 1:length(Img)
   tempf = double(Img{i}(gridxROIRange(1):gridxROIRange(2), gridyROIRange(1):gridyROIRange(2)));
   fAvg = mean(tempf(:)); fstd = std(tempf(:));
   ImgNormalized{i} = (double(Img{i})-fAvg)/fstd;
end





function [xPos,yPos] = angio_ACA_TOP(X)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 23-Jan-2024
%----------------------------------------------------


% Adjust data to span data range.
X = imadjust(X);

% Create empty mask
BW = false(size(X,1),size(X,2));

% Draw ROIs

xPos = [264.7366 259.6884 259.5998 258.2713 257.3857 256.5000 256.0572 255.1715 254.9944 254.6401 254.6401 254.2859 254.2859 254.1973 254.1973 254.1973 254.1973 254.2859 254.2859 254.2859 254.9944 255.2601 255.5258 256.3229 257.4742 258.0942 259.5998 260.0426 262.1682 262.9653 264.8252 265.7994 266.1537 267.5707 268.2793 268.8992 269.7849 270.2277 270.7591 271.1134 271.4677 271.8219 271.9105 271.9990 271.9990 271.9990 271.9990 271.6448 271.5562 271.2020 270.7591 270.1392 269.4306 268.8992 268.4564 266.7737 265.8880 265.4452 264.7366 264.4709 264.4709 264.9138 265.0023 265.7109 265.7109 265.3566 265.2680 265.1795 265.1795 265.1795 264.9138 264.7366 264.5595 264.0000 264.0000];
yPos = [183.4647 182.2246 182.2246 183.0218 183.6419 184.3505 184.7934 186.2993 187.4509 188.6024 188.9567 190.9941 192.5000 193.4744 195.0689 196.0433 197.4606 198.9664 200.2952 201.6239 203.5727 204.3699 204.7242 205.3443 206.9388 207.5588 208.8875 209.1533 210.0391 210.0391 209.5962 209.4190 209.4190 208.9761 208.7104 208.0017 207.3817 206.9388 206.5844 206.0529 205.3443 204.8128 204.2813 203.2183 202.5097 202.0668 201.8896 201.1810 200.7381 200.3837 200.1180 199.4093 199.0550 198.7893 198.7007 198.7893 198.9664 198.9664 198.5235 198.1692 196.9291 194.5374 194.0945 191.9685 189.6654 188.0709 187.1851 186.2107 186.1221 184.7934 183.9076 182.7561 182.6675 183.7013 183.2987];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;

% Active contour
iterations = 15;
BW = activecontour(X, BW, iterations, 'edge');

% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;
end

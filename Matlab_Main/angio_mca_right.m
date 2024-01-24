function [xPos,yPos] = angio_mca_right(X)
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

xPos = [283.7622 291.8295 293.2205 294.4723 295.1678 295.7241 296.4196 296.9760 297.9496 298.0887 298.5060 298.6451 299.2014 299.4796 300.1751 300.7315 301.4269 302.6788 303.6524 304.0697 304.3479 305.3215 305.7388 306.4343 306.9906 307.6861 308.2425 308.3816 308.5206 309.4943 309.9116 310.4679 310.6070 311.1634 311.7198 312.2761 312.4152 312.5543 312.6934 313.1107 313.2498 313.2498 312.6934 312.4152 311.5807 309.4943 307.4079 306.2952 305.3215 304.9042 304.2088 303.5133 303.3742 302.9569 298.6451 297.8105 296.2805 295.1678 293.7768 292.8032 291.5513 290.4386 289.6040 288.2131 286.8222 285.1531 283.4840 282.7885 282.6494 282.3712 282.3712 282.5103 282.5103 282.7885 283.0667 283.2058 283.3449 283.3449 283.4840 283.9012 283.0000 283.0000];
yPos = [216.9389 210.9595 209.7080 208.8737 208.1784 207.7613 207.2051 206.7879 206.0926 205.3973 204.9802 204.7021 204.2849 204.1458 204.0068 203.7287 203.5896 203.3115 203.3115 203.3115 203.3115 203.4506 204.0068 204.4240 204.7021 204.9802 205.3973 205.3973 205.3973 205.5364 205.5364 205.5364 205.3973 205.1192 205.1192 204.8411 204.8411 204.7021 204.7021 204.7021 204.9802 205.5364 207.6222 208.1784 208.8737 210.9595 212.6282 213.4625 215.1312 215.5483 216.6608 217.9123 218.0513 218.1904 221.3886 222.0839 223.0573 223.7526 224.4479 225.1431 225.1431 225.6993 225.9775 226.3946 226.6727 226.6727 226.5337 226.2556 224.8650 223.6135 222.9183 220.1372 219.4419 218.1904 217.9123 217.3561 217.2170 216.9389 216.7998 216.5217 217.7013 217.2987];
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


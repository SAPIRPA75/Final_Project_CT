function [xPos,yPos] = Reg_MCA_LEFT(X)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 28-Mar-2024
%----------------------------------------------------


% Adjust data to span data range.
X = imadjust(X);

% Create empty mask
BW = false(size(X,1),size(X,2));

% Draw ROIs

xPos = [289.6722 289.3498 288.8274 288.3995 288.1610 288.0288 287.9314 287.8170 287.7026 287.6052 287.4908 287.3764 287.2700 287.1069 286.8782 286.6354 286.3977 286.1948 286.0228 285.8597 285.6966 285.5423 285.4102 285.2729 285.0840 284.8988 284.7666 284.6781 284.5946 284.4972 284.3341 284.1231 283.9511 283.8049 283.6249 283.4706 283.3643 283.2410 283.0868 282.9059 282.6632 282.3509 282.0374 281.7650 281.5879 281.4291 281.1952 280.8918 280.6092 280.3627 280.1597 279.9788 279.7759 279.5471 279.3442 279.1722 279.0091 278.8460 278.6917 278.5596 278.4223 278.2423 278.0791 277.9330 277.7529 277.5987 277.4924 277.3691 277.2149 277.0518 276.8975 276.7743 276.6768 276.5536 276.3993 276.2362 276.0820 275.9498 275.8126 275.6236 275.4207 275.2177 275.0199 274.8428 274.6450 274.4509 274.2700 274.0760 273.8781 273.7010 273.5121 273.3579 273.2426 273.0884 272.9084 272.7711 272.6300 272.4360 272.2072 272.0132 271.8810 271.7836 271.6603 271.5149 271.3917 271.2942 271.1709 271.0256 270.9112 270.8536 270.8049 270.7392 270.6905 270.6418 270.5761 270.5363 270.5274 270.5274 270.5274 270.5274 270.5274 270.5363 270.5761 270.6418 270.6905 270.7481 270.8625 271.0167 271.1709 271.2942 271.3917 271.5061 271.6204 271.7179 271.8323 271.9467 272.0441 272.1763 272.3792 272.6478 272.9164 273.1194 273.2515 273.3490 273.4723 273.6265 273.7896 273.9527 274.1158 274.2789 274.4509 274.6538 274.8915 275.1432 275.4296 275.7380 276.0155 276.2362 276.4392 276.6370 276.8052 276.9543 277.0429 277.1005 277.1750 277.2636 277.3958 277.5809 277.7610 277.8584 277.9160 277.9906 278.0791 278.1935 278.3168 278.4452 278.5943 278.7227 278.8460 278.9604 279.0489 279.1235 279.1722 279.2209 279.2955 279.3840 279.5073 279.6615 279.8246 279.9877 280.1508 280.3140 280.4682 280.5915 280.6889 280.8033 280.9177 281.0151 281.1562 281.3900 281.6845 281.9362 282.1480 282.3369 282.4653 282.5577 282.6373 282.7296 282.8491 282.9983 283.1266 283.2677 283.4617 283.6905 283.9024 284.1142 284.3519 284.6035 284.8810 285.1585 285.4191 285.7054 286.0228 286.3312 286.5778 286.7638 286.9616 287.1557 287.3365 287.5395 287.7860 288.0686 288.3720 288.6236 288.8444 289.0642 289.2274 289.3337 289.4570 289.6023 289.7256 289.8230 289.9463 290.0916 290.2149 290.3123 290.4356 290.5809 290.6953 290.7441 290.7618 290.8017 290.8673 290.9072 290.9249 290.9648 291.0304 291.0703 291.0792 291.0792 291.0792 291.0792 291.0792 291.0703 291.0304 290.9648 290.9249 290.9072 290.8673 290.7928 290.7131 290.6297 290.5500 290.4666 290.3780 290.2547 290.1005 289.9374 289.7832 289.6599 289.5625 289.4481 289.3426 289.2939];
yPos = [202.3477 202.3566 202.3964 202.4710 202.5596 202.6739 202.7794 202.8371 202.8858 202.9514 203.0002 203.0489 203.1323 203.2518 203.4009 203.5293 203.6526 203.7581 203.8157 203.8733 203.9788 204.0932 204.1818 204.2563 204.3050 204.3626 204.4681 204.5825 204.6711 204.7545 204.8342 204.9176 204.9973 205.0807 205.1693 205.2837 205.3892 205.4468 205.4955 205.5790 205.7073 205.8963 206.0903 206.2535 206.3767 206.4831 206.6373 206.8173 206.9457 207.0381 207.1266 207.2499 207.4041 207.5672 207.7214 207.8447 207.9422 208.0565 208.1709 208.2595 208.3518 208.4802 208.6603 208.8145 208.9208 209.0352 209.1496 209.2470 209.3703 209.5156 209.6389 209.7452 209.8995 210.0795 210.2079 210.3091 210.4375 210.6265 210.8205 211.0014 211.2043 211.4331 211.6361 211.8081 211.9712 212.1343 212.2974 212.4694 212.6634 212.8524 212.9897 213.1129 213.2362 213.3735 213.5624 213.7476 213.8886 214.0259 214.2060 214.3602 214.4665 214.5898 214.7440 214.9071 215.0614 215.1846 215.2821 215.4054 215.5596 215.7138 215.8460 215.9832 216.1722 216.3751 216.5958 216.8644 217.1331 217.3449 217.5169 217.6800 217.8520 218.0460 218.2350 218.3723 218.4955 218.6099 218.7163 218.8705 219.0505 219.1878 219.3111 219.4255 219.5140 219.5886 219.6373 219.6860 219.7606 219.8491 219.9724 220.1177 220.2321 220.2897 220.3385 220.4041 220.4440 220.4529 220.4529 220.4529 220.4529 220.4529 220.4529 220.4440 220.3864 220.2321 220.0034 219.7606 219.5229 219.3200 219.1480 218.9849 218.8218 218.6586 218.5044 218.3811 218.2926 218.2092 218.1117 217.9486 217.7287 217.5347 217.4025 217.3139 217.2305 217.1419 217.0187 216.8644 216.7102 216.5958 216.5382 216.4895 216.4150 216.3264 216.2120 216.0976 216.0091 215.9256 215.8460 215.7536 215.6341 215.4850 215.3655 215.2821 215.2334 215.1846 215.1101 215.0215 214.9071 214.7927 214.6953 214.5720 214.4178 214.2636 214.1403 214.0518 213.9683 213.8886 213.8052 213.7167 213.5934 213.4480 213.3248 213.2273 213.0952 212.9011 212.6812 212.5181 212.4029 212.2398 212.0199 211.8081 211.5962 211.3675 211.1645 210.9925 210.8294 210.6752 210.5519 210.4545 210.3312 210.1681 209.9651 209.7275 209.4847 209.2470 209.0441 208.8721 208.7090 208.5548 208.4226 208.2853 208.0964 207.9023 207.7303 207.5672 207.3952 207.1923 206.9635 206.7606 206.5886 206.4255 206.2623 206.0992 205.9361 205.7730 205.6099 205.4468 205.2837 205.1117 204.9088 204.6800 204.4770 204.3050 204.1419 203.9877 203.8644 203.7670 203.6437 203.4895 203.3264 203.1722 203.0489 202.9603 202.8769 202.7972 202.7138 202.6341 202.5596 202.5197 202.5019 202.4621 202.3964 202.3477 202.2990 202.2333];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;

% Active contour
iterations = 5;
BW = activecontour(X, BW, iterations, 'edge');

% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;
end


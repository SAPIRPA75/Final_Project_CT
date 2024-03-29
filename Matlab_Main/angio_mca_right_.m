function [xPos,yPos] = angio_MCA_right(X)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 24-Jan-2024
%----------------------------------------------------


% Adjust data to span data range.
X = imadjust(X);

% Create empty mask
BW = false(size(X,1),size(X,2));

% Draw ROIs

xPos = [310.9639 310.5707 310.1774 309.7842 309.3909 308.9977 308.6045 308.2112 307.8180 307.4247 307.0315 306.6382 306.2450 305.8518 305.4585 305.0653 304.6720 304.2788 303.8856 303.4923 303.0991 302.7058 302.3126 301.9194 301.5261 301.1329 300.7396 300.3464 299.9531 299.5599 299.1667 298.7734 298.3802 297.9869 297.5937 297.2005 296.8072 296.8072 296.4140 296.0207 295.6275 295.2343 294.8410 294.4478 294.0545 293.6613 293.2680 292.8748 292.4816 292.0883 291.6951 291.3018 291.3018 290.9086 290.1221 289.7289 288.9424 288.9424 288.5492 288.1559 287.7627 287.7627 287.3694 286.9762 286.9762 286.5829 286.1897 285.7965 285.4032 285.0100 284.6167 284.6167 284.2235 284.2235 283.4370 282.6505 282.6505 282.2573 282.2573 281.8641 281.8641 281.0776 281.0776 280.6843 280.2911 279.8978 279.8978 279.1114 279.1114 278.7181 278.7181 278.3249 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 277.9316 278.3249 278.7181 278.7181 278.7181 279.1114 279.1114 279.5046 279.8978 279.8978 280.6843 281.0776 281.4708 281.8641 282.2573 282.6505 283.0438 283.4370 283.8303 284.2235 284.6167 285.4032 285.4032 285.7965 286.1897 286.5829 286.9762 287.3694 287.7627 288.1559 288.5492 288.9424 289.3356 289.7289 290.1221 290.5154 290.9086 291.3018 291.6951 292.0883 292.4816 292.8748 293.2680 293.6613 294.0545 294.4478 295.2343 295.6275 296.0207 296.4140 297.2005 297.5937 297.9869 298.3802 298.7734 299.1667 299.5599 299.9531 300.3464 300.7396 301.1329 301.5261 302.3126 302.3126 302.7058 303.0991 303.4923 303.4923 303.8856 304.2788 304.2788 304.6720 305.0653 305.4585 305.8518 305.8518 306.2450 306.2450 306.2450 306.6382 307.0315 307.0315 307.4247 307.4247 307.8180 307.8180 307.8180 308.2112 308.2112 308.6045 308.6045 308.6045 308.9977 308.9977 308.9977 308.9977 308.9977 309.3909 309.7842 309.7842 309.7842 309.7842 309.7842 309.7842 309.7842 309.7842 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.5707 310.2987 310.7013];
yPos = [202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.0361 202.4293 202.4293 202.4293 202.8226 203.2158 203.2158 203.6091 203.6091 204.0023 204.0023 204.3955 204.7888 204.7888 205.1820 205.1820 205.1820 205.1820 205.5753 205.9685 205.9685 206.3618 206.7550 206.7550 207.1482 207.5415 207.5415 207.5415 207.9347 207.9347 208.3280 208.7212 208.7212 208.7212 209.1144 209.5077 209.5077 209.9009 210.2942 210.2942 210.6874 210.6874 211.0806 211.4739 211.4739 211.8671 211.8671 212.2604 212.2604 212.6536 213.0469 213.0469 213.8333 214.2266 214.6198 215.0131 215.4063 215.7995 216.1928 216.1928 216.9793 217.3725 217.7657 218.1590 218.5522 218.9455 219.3387 219.7320 220.1252 220.5184 220.9117 221.3049 221.6982 222.0914 222.4846 222.8779 223.2711 224.0576 224.4508 224.4508 224.8441 225.2373 225.6306 225.6306 225.6306 226.0238 226.0238 226.0238 226.0238 226.0238 226.4171 226.4171 226.4171 226.4171 226.8103 226.8103 226.8103 226.8103 227.2035 227.2035 227.2035 227.5968 227.5968 227.5968 227.5968 227.5968 227.5968 227.5968 227.9900 227.9900 227.9900 227.9900 227.9900 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 228.3833 227.9900 227.9900 227.9900 227.5968 227.2035 227.2035 226.8103 226.8103 226.4171 226.4171 226.4171 226.0238 225.6306 225.2373 224.8441 224.8441 224.4508 224.4508 224.0576 223.6644 223.2711 223.2711 222.8779 222.4846 222.0914 221.6982 221.3049 220.9117 220.5184 220.1252 219.7320 219.3387 218.5522 218.5522 217.7657 217.3725 216.9793 216.5860 216.1928 215.7995 215.4063 215.0131 214.6198 214.2266 213.8333 213.4401 213.0469 212.2604 211.8671 211.4739 211.0806 210.6874 210.2942 209.9009 209.5077 209.1144 208.7212 208.3280 207.9347 207.5415 207.1482 206.7550 206.3618 205.9685 205.5753 205.1820 204.7888 204.3955 204.0023 203.6091 203.2158 202.8226 202.4293 202.0361 203.0000 203.0000];
m = size(BW, 1);
n = size(BW, 2);
addedRegion = poly2mask(xPos, yPos, m, n);
BW = BW | addedRegion;

% Active contour
iterations = 35;
BW = activecontour(X, BW, iterations, 'edge');

% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;
end

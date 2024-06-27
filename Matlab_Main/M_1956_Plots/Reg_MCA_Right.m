function [xPos,yPos] = Reg_MCA_Right(X)
%segmentImage Segment image using auto-generated code from Image Segmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the Image Segmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 05-Apr-2024
%----------------------------------------------------


% Adjust data to span data range.
X = imadjust(X);

% Create empty mask
BW = false(size(X,1),size(X,2));

% Draw ROIs

xPos = [267.4848 267.4279 267.3467 267.2539 267.1438 266.9975 266.8240 266.6335 266.4740 266.3354 266.1902 266.0516 265.8878 265.6740 265.4458 265.2256 265.0395 264.8824 264.7557 264.6479 264.5350 264.4233 264.3281 264.2300 264.1266 264.0273 263.9250 263.8066 263.6676 263.5335 263.4121 263.2949 263.1778 263.0563 262.9180 262.7513 262.5591 262.3515 262.1508 261.9396 261.7119 261.5062 261.3273 261.1281 260.8871 260.5866 260.2724 260.0019 259.7582 259.5195 259.2940 259.0963 258.8690 258.5614 258.1485 257.6346 257.2338 256.9665 256.7322 256.4883 256.2383 255.9881 255.7294 255.4787 255.2640 255.0231 254.7111 254.3776 254.0640 253.7740 253.5152 253.2683 253.0266 252.7880 252.5506 252.3270 252.1208 251.9015 251.6831 251.4781 251.2671 251.0583 250.8650 250.6655 250.4492 250.2382 250.0555 249.8888 249.6844 249.4110 249.1659 248.9790 248.8281 248.6800 248.5062 248.3406 248.2159 248.1071 247.9771 247.8064 247.6163 247.4159 247.2025 246.9834 246.8081 246.6684 246.5006 246.2919 246.0978 245.9543 245.8431 245.7070 245.5169 245.2904 245.0941 244.9546 244.8352 244.6885 244.5113 244.3298 244.1662 244.0227 243.8810 243.7220 243.5688 243.4316 243.3166 243.2162 243.0915 242.9219 242.7372 242.5202 242.2392 241.9709 241.7622 241.5949 241.3697 241.0647 240.8208 240.6705 240.5321 240.3816 240.2185 239.9231 239.4725 239.1079 238.8879 238.7063 238.5069 238.3043 238.1069 237.9116 237.7143 237.5158 237.3356 237.1811 237.0059 236.8101 236.6514 236.5164 236.3620 236.1661 235.9407 235.6871 235.4801 235.3364 235.2192 235.1116 235.0144 234.9302 234.8678 234.8149 234.7602 234.7137 234.6842 234.6725 234.6704 234.6704 234.6704 234.6704 234.6704 234.6725 234.6884 234.7349 234.8075 234.8847 234.9637 235.0409 235.1242 235.2247 235.3606 235.5255 235.7131 235.8967 236.0807 236.3107 236.5763 236.8256 237.0620 237.2930 237.5149 237.7395 237.9431 238.1198 238.2988 238.4636 238.6231 238.8036 238.9975 239.1644 239.3122 239.4675 239.6382 239.8094 239.9930 240.1828 240.3678 240.5650 240.7526 240.9166 241.0981 241.2941 241.4824 241.7050 241.9699 242.2439 242.5064 242.7948 243.0867 243.4084 243.7856 244.1792 244.5326 245.0293 245.7298 246.2648 246.5577 246.7743 247.0106 247.2468 247.4528 247.6363 247.8289 248.0809 248.3602 248.6288 248.9103 249.1654 249.3558 249.5599 249.8572 250.1816 250.4440 250.6835 250.9219 251.1533 251.3884 251.6048 251.8183 252.0779 252.3784 252.6719 252.9271 253.1364 253.3304 253.5271 253.7568 254.0340 254.4125 254.8524 255.2360 255.4952 255.7075 255.9321 256.1559 256.3712 256.5845 256.8243 257.1121 257.4353 257.7823 258.1050 258.3757 258.6340 258.8703 259.0712 259.2811 259.5165 259.7612 260.0148 260.2996 260.5906 260.8495 261.0826 261.2874 261.4669 261.6314 261.7857 261.9536 262.1455 262.3451 262.5422 262.7379 262.9656 263.1945 263.3930 263.5897 263.8225 264.0643 264.2998 264.5295 264.7346 264.9286 265.1317 265.3729 265.6210 265.8854 266.1833 266.4453 266.6735 266.9184 267.2053 267.5767 268.0275 268.3640 268.5730 268.7368 268.9227 269.1568 269.4100 269.6379 269.8141 269.9410 270.0529 270.1658 270.2691 270.3494 270.4118 270.4708 270.5289 270.5879 270.6439 270.6934 270.7337 270.7737 270.8118 270.8496 270.8804 270.9120 270.9489 270.9880 271.0249 271.0544 271.0756 271.0935 271.1030 271.1051 271.1051 271.1051 271.0988 271.0701 271.0187 270.9625 270.8866 270.7982 270.7166 270.6068 270.4625 270.3210 270.2072 270.1267 270.0389 269.9115 269.7721 269.6445 269.5357 269.4333 269.3266 269.2150 269.1135 269.0100 268.8802 268.7175 268.5396 268.4034 268.3071 268.1973 268.0634 267.9422 267.8565 267.7858 267.7194 267.6570 267.5884 267.5146 267.4481 267.3953 267.3446 267.2898 267.2433 267.2138];
yPos = [224.6342 224.6364 224.6480 224.6797 224.7357 224.8125 224.9014 225.0014 225.0912 225.1726 225.2536 225.3214 225.4038 225.5133 225.6296 225.7476 225.8639 225.9756 226.0611 226.1203 226.1806 226.2532 226.3230 226.3937 226.4696 226.5477 226.6280 226.7156 226.8116 226.9087 227.0026 227.0828 227.1547 227.2337 227.3247 227.4385 227.5631 227.6898 227.8152 227.9357 228.0570 228.1646 228.2577 228.3545 228.4551 228.5710 228.6934 228.8085 228.9065 228.9880 229.0627 229.1273 229.1992 229.3003 229.4368 229.6019 229.7255 229.7985 229.8597 229.9273 230.0021 230.0740 230.1521 230.2322 230.2945 230.3495 230.4159 230.4919 230.5679 230.6343 230.6850 230.7262 230.7653 230.8022 230.8317 230.8550 230.8824 230.9098 230.9310 230.9489 230.9584 230.9605 230.9627 230.9722 230.9879 230.9975 231.0017 231.0134 231.0386 231.0639 231.0756 231.0777 231.0798 231.0893 231.1051 231.1146 231.1167 231.1167 231.1167 231.1167 231.1167 231.1167 231.1167 231.1167 231.1167 231.1167 231.1167 231.1167 231.1167 231.1146 231.1029 231.0777 231.0503 231.0291 231.0112 231.0017 230.9996 230.9996 230.9996 230.9996 230.9996 230.9996 230.9996 230.9996 230.9996 230.9996 230.9996 231.0017 231.0134 231.0386 231.0660 231.0872 231.1072 231.1284 231.1558 231.1853 231.2182 231.2613 231.2982 231.3237 231.3510 231.3784 231.4103 231.4779 231.5777 231.6549 231.7046 231.7553 231.8197 231.8861 231.9485 232.0170 232.0951 232.1807 232.2649 232.3390 232.4150 232.4855 232.5321 232.5775 232.6419 232.7242 232.8288 232.9445 233.0355 233.1105 233.1864 233.2645 233.3405 233.4091 233.4715 233.5422 233.6255 233.7120 233.7934 233.8798 233.9675 234.0551 234.1437 234.2389 234.3601 234.4930 234.6337 234.8109 235.0026 235.1634 235.3014 235.4176 235.5221 235.6331 235.7660 235.9084 236.0425 236.1605 236.2674 236.3929 236.5268 236.6344 236.7085 236.7696 236.8256 236.8730 236.9037 236.9237 236.9332 236.9332 236.9237 236.9080 236.8984 236.8963 236.8963 236.8942 236.8825 236.8573 236.8299 236.8065 236.7749 236.7306 236.6853 236.6503 236.6113 236.5682 236.5332 236.4877 236.4160 236.3339 236.2662 236.2125 236.1584 236.0794 235.9791 235.8790 235.7965 235.6960 235.5721 235.4916 235.4514 235.4262 235.4145 235.4124 235.4124 235.4124 235.4145 235.4240 235.4398 235.4514 235.4631 235.4788 235.4883 235.4905 235.4905 235.4905 235.4905 235.4905 235.4905 235.4905 235.4905 235.4862 235.4650 235.4219 235.3733 235.3247 235.2795 235.2488 235.2245 235.1938 235.1443 235.0724 234.9669 234.8425 234.7370 234.6630 234.6018 234.5437 234.4847 234.4287 234.3771 234.3230 234.2482 234.1627 234.0751 233.9887 233.9072 233.8229 233.7470 233.6824 233.6139 233.5379 233.4598 233.3796 233.2919 233.1960 233.0988 233.0029 232.9152 232.8371 232.7685 232.7040 232.6259 232.5321 232.4371 232.3485 232.2671 232.1785 232.0856 231.9949 231.9018 231.7880 231.6635 231.5389 231.4251 231.3341 231.2530 231.1715 231.0756 230.9679 230.8496 230.7200 230.6038 230.5015 230.4043 230.2870 230.1062 229.8761 229.7088 229.6033 229.5135 229.4099 229.2792 229.1389 229.0144 228.9163 228.8422 228.7715 228.6934 228.6101 228.5374 228.4929 228.4570 228.4084 228.3420 228.2681 228.1974 228.1276 228.0529 227.9831 227.9124 227.8343 227.7445 227.6412 227.5336 227.4226 227.2993 227.1768 227.0607 226.9349 226.8013 226.6965 226.5961 226.4611 226.2965 226.1353 225.9977 225.8544 225.7183 225.6105 225.5070 225.3879 225.2792 225.2085 225.1693 225.1281 225.0733 225.0173 224.9678 224.9276 224.8919 224.8707 224.8569 224.8390 224.8200 224.8021 224.7926 224.7883 224.7788 224.7631 224.7514 224.7397 224.7240 224.7145 224.7102 224.7007 224.6828 224.6638 224.6459 224.6364 224.6342 224.6342 224.6342 224.6342 224.6342];
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

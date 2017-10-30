clear 
close all;
f_division = imread('f_division.bmp');

f_thin1 = bwmorph(f_division,'thin',Inf);                   % 细化预处理过程
figure, imshow(f_thin1);

binary_pattern = imread('f_thin1_binary_pattern.bmp');      % 细化后容易勾勒出指纹的范围，由此手动造了一个二值图，用于去除指纹外围的干扰
bp = imcomplement(binary_pattern);              
figure, imshow(bp);

f_thin1 = f_thin1.*bp;                                      % 图像上只剩指纹

figure,imshow(f_thin1);
imwrite(f_thin1,'f_thin1.bmp');

close all;
hou0 = fudu.*cos(xiangwei);                         %用实部去做进一步的锐化
lpfilter = fspecial('laplacian',0.1);               %laplace滤波器
lp1 = imfilter(hou0, lpfilter,'replicate');         %用滤波器锐化

hou0_binary = imread('hou_binary.jpg');             %读入手工做的二值图（指纹部分为黑）
hou1 = im2double(hou0_binary);
hou2 =imcomplement(hou1);                           %二值图反向（指纹部分为白）

hou_final = lp1 .* hou2;                            %用自己做的二值图取出锐化后的图像中的指纹部分
imshow(hou_final);                          
imwrite(hou_final,'hou_final.jpg');                 
% Gabor filter
clear all;
close all;
I = imread('1_1.bmp');          
imshow(I,[]);
I = im2double(I);
[M, N] = size(I);

wavelength = 8;
% Create array of Gabor filters. This filter bank contains 16 orientations and 1 wavelength.
orientation_num = 16;
orientations = [0:orientation_num-1]*180/orientation_num;
gaborArray = gabor(wavelength,orientations);
% Apply filters to input image
[mag,phase] = imgaborfilt(I,gaborArray);  

shibu = mag.*cos(phase);            % 16个方向对应 M * N * 16 的实部
weight = zeros(size(mag));
real = zeros(size(I));
for i = 1:M
    for j = 1:N
        total = sum(mag(i,j,:).^5);
        for k = 1:orientation_num
            weight(i, j, k) = mag(i,j,k)^5 / total;     % 这是对每个像素点由16个方向的幅度求出的权重，用5次方来做权，可以在不忽略小权重的情况下，尽可能凸显大权重的部分
        end
        tmp = weight(i,j,:) .* shibu(i,j,:);            % 用刚刚求的的权重作用在实部上，因为只有实部或虚部才有实用价值
        real(i,j) = sum(tmp);                           % 然后求和（权重和为1），得到最终的gabor滤波后的结果
    end
end

figure, imshow(real,[]);
imwrite(real,'real_part.bmp');




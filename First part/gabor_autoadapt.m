% Gabor filter
clear all;
close all;
I = imread('halfway.bmp');          %读入用陷波器处理过的去除了背景纹理的图像
I = im2double(I);
[M, N] = size(I);
fudu = zeros(size(I));               %初始化幅度
xiangwei = fudu;                     %初始化相位

wavelength = 10;
% Create array of Gabor filters. This filter bank contains 16 orientations and 1 wavelength.
orientation_num = 16;
orientations = [0:orientation_num-1]*180/orientation_num;
gaborArray = gabor(wavelength,orientations);
% Apply filters to input image
[mag,phase] = imgaborfilt(I,gaborArray);
for i = 1:M
    for j = 1:N                                 %对每一个像素操作
        temp = max(mag(i,j,:));                 %找出16个方向滤波中幅度最强的图的幅度
        ind = find(mag(i,j,:) == temp);         %找出是16个图中哪一个是最大的
        fudu(i,j) = temp;                        %对幅度赋值为最强幅度
        xiangwei(i,j) = phase(i,j,ind);         %把相位用16个图的最强幅度的图相位赋值
    end
end

           
figure(1), set(1, 'name', 'Magnitude');
figure(2), set(2, 'name', 'Phase');
figure(3), set(3, 'name', 'Even Gabor');
figure(4), set(4, 'name', 'Odd Gabor');
    
figure(1),imshow(fudu,[]);                       %幅度图
figure(2),imshow(xiangwei,[]);                  %相位图
figure(3),imshow(fudu.*cos(xiangwei),[]);        %实部
figure(4),imshow(fudu.*sin(xiangwei),[]);        %虚部


%real = fudu.*cos(xiangwei);
%imaginary = fudu.*sin(xiangwei);

%imwrite(fudu,'fudu.bmp');
%imwrite(xiangwei,'xiangwei.bmp');
%imwrite(real,'real_part.bmp');
%imwrite(imaginary,'imaginary_part.bmp');



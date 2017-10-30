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

shibu = mag.*cos(phase);            % 16�������Ӧ M * N * 16 ��ʵ��
weight = zeros(size(mag));
real = zeros(size(I));
for i = 1:M
    for j = 1:N
        total = sum(mag(i,j,:).^5);
        for k = 1:orientation_num
            weight(i, j, k) = mag(i,j,k)^5 / total;     % ���Ƕ�ÿ�����ص���16������ķ��������Ȩ�أ���5�η�����Ȩ�������ڲ�����СȨ�ص�����£�������͹�Դ�Ȩ�صĲ���
        end
        tmp = weight(i,j,:) .* shibu(i,j,:);            % �øո���ĵ�Ȩ��������ʵ���ϣ���Ϊֻ��ʵ�����鲿����ʵ�ü�ֵ
        real(i,j) = sum(tmp);                           % Ȼ����ͣ�Ȩ�غ�Ϊ1�����õ����յ�gabor�˲���Ľ��
    end
end

figure, imshow(real,[]);
imwrite(real,'real_part.bmp');




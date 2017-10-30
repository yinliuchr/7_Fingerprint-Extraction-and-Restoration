% Gabor filter
clear all;
close all;
I = imread('halfway.bmp');          %�������ݲ����������ȥ���˱��������ͼ��
I = im2double(I);
[M, N] = size(I);
fudu = zeros(size(I));               %��ʼ������
xiangwei = fudu;                     %��ʼ����λ

wavelength = 10;
% Create array of Gabor filters. This filter bank contains 16 orientations and 1 wavelength.
orientation_num = 16;
orientations = [0:orientation_num-1]*180/orientation_num;
gaborArray = gabor(wavelength,orientations);
% Apply filters to input image
[mag,phase] = imgaborfilt(I,gaborArray);
for i = 1:M
    for j = 1:N                                 %��ÿһ�����ز���
        temp = max(mag(i,j,:));                 %�ҳ�16�������˲��з�����ǿ��ͼ�ķ���
        ind = find(mag(i,j,:) == temp);         %�ҳ���16��ͼ����һ��������
        fudu(i,j) = temp;                        %�Է��ȸ�ֵΪ��ǿ����
        xiangwei(i,j) = phase(i,j,ind);         %����λ��16��ͼ����ǿ���ȵ�ͼ��λ��ֵ
    end
end

           
figure(1), set(1, 'name', 'Magnitude');
figure(2), set(2, 'name', 'Phase');
figure(3), set(3, 'name', 'Even Gabor');
figure(4), set(4, 'name', 'Odd Gabor');
    
figure(1),imshow(fudu,[]);                       %����ͼ
figure(2),imshow(xiangwei,[]);                  %��λͼ
figure(3),imshow(fudu.*cos(xiangwei),[]);        %ʵ��
figure(4),imshow(fudu.*sin(xiangwei),[]);        %�鲿


%real = fudu.*cos(xiangwei);
%imaginary = fudu.*sin(xiangwei);

%imwrite(fudu,'fudu.bmp');
%imwrite(xiangwei,'xiangwei.bmp');
%imwrite(real,'real_part.bmp');
%imwrite(imaginary,'imaginary_part.bmp');



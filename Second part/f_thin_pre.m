clear 
close all;
f_division = imread('f_division.bmp');

f_thin1 = bwmorph(f_division,'thin',Inf);                   % ϸ��Ԥ�������
figure, imshow(f_thin1);

binary_pattern = imread('f_thin1_binary_pattern.bmp');      % ϸ�������׹��ճ�ָ�Ƶķ�Χ���ɴ��ֶ�����һ����ֵͼ������ȥ��ָ����Χ�ĸ���
bp = imcomplement(binary_pattern);              
figure, imshow(bp);

f_thin1 = f_thin1.*bp;                                      % ͼ����ֻʣָ��

figure,imshow(f_thin1);
imwrite(f_thin1,'f_thin1.bmp');

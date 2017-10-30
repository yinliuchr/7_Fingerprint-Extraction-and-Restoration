close all;
hou0 = fudu.*cos(xiangwei);                         %��ʵ��ȥ����һ������
lpfilter = fspecial('laplacian',0.1);               %laplace�˲���
lp1 = imfilter(hou0, lpfilter,'replicate');         %���˲�����

hou0_binary = imread('hou_binary.jpg');             %�����ֹ����Ķ�ֵͼ��ָ�Ʋ���Ϊ�ڣ�
hou1 = im2double(hou0_binary);
hou2 =imcomplement(hou1);                           %��ֵͼ����ָ�Ʋ���Ϊ�ף�

hou_final = lp1 .* hou2;                            %���Լ����Ķ�ֵͼȡ���񻯺��ͼ���е�ָ�Ʋ���
imshow(hou_final);                          
imwrite(hou_final,'hou_final.jpg');                 
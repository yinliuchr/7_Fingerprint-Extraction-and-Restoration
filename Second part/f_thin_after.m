clear 
close all;
A = imread('f_thin1.bmp');

C = Pruning(A, 10);                      % ϸ�����޼�����
D = bwmorph(C,'clean');                  % ��һ�������õ�ϸ����ɵ�ͼ��

figure(1),
ax(1)=subplot(1,3,1); imshow(A); title('A');
ax(2)=subplot(1,3,2); imshow(C); title('C');
ax(3)=subplot(1,3,3); imshow(D); title('D');

linkaxes(ax);
figure,imshow(A);
figure,imshow(D);

imwrite(D,'f_thin.bmp');
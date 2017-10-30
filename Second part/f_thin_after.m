clear 
close all;
A = imread('f_thin1.bmp');

C = Pruning(A, 10);                      % 细化后修剪过程
D = bwmorph(C,'clean');                  % 进一步处理，得到细化完成的图像

figure(1),
ax(1)=subplot(1,3,1); imshow(A); title('A');
ax(2)=subplot(1,3,2); imshow(C); title('C');
ax(3)=subplot(1,3,3); imshow(D); title('D');

linkaxes(ax);
figure,imshow(A);
figure,imshow(D);

imwrite(D,'f_thin.bmp');
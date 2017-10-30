clear
close all;

f = imread('real_part.bmp');

f = im2bw(f,0.5);
f = imcomplement(f);                    %   转化成黑背景的逻辑二值图

b = 10;

se1 = direction_line(7,b);
se2 = direction_line(7,b);               %   用自定义的direction_line函数构造2个结构元素

f_division = zeros(size(f));

for i = 1:b
    fo(:,:,i) = imdilate(imerode(f,se1(i)),se2(i));     % 做一个腐蚀再膨胀的过程，经过比较调参，2个结构元素用的是一样的，所以相当于开运算
    f_division = max(f_division, fo(:,:,i));            % 把每个方向场上提取到的信息结合起来
end

f_division = im2bw(f_division);

% se3 = strel('disk', 5);
% tmp = imclose(f_division, se3);
% f_division = imcomplement(tmp - f_division);
% 
% se4 = strel('disk', 1);
% f_division = imclose(f_division, se4);

figure(1),
ax(1)=subplot(1,2,1); imshow(f); title('Original');
ax(2)=subplot(1,2,2); imshow(f_division); title('f_division');
linkaxes(ax);
imwrite(f_division, 'f_division.bmp');
clear
close all;

a = imread('f_thin.bmp');
b = false(size(a));                 % b 用来存储端点
c = b;                              % c 用来存储交叉点

se = strel('disk',2);               % 用于最后处理找出的细节点的膨胀的结构元素

for i = 2:size(a,1)-1
    for j = 2:size(a,2)-1
        if a(i,j) == 0
            continue;               % 端点和交叉点一定是指纹上的点，所以舍去0像素点
        end
        cn = abs( a(i-1,j)-a(i-1,j-1)); 
        cn = cn + abs(a(i-1,j+1)-a(i-1,j));
        cn = cn + abs(a(i,j+1)-a(i-1,j+1));
        cn = cn + abs(a(i+1,j+1)-a(i,j+1));
        cn = cn + abs(a(i+1,j)-a(i+1,j+1));
        cn = cn + abs(a(i+1,j-1)-a(i+1,j));
        cn = cn + abs(a(i,j-1)-a(i+1,j-1));
        cn = cn + abs(a(i-1,j-1)-a(i,j-1));
        cn = cn / 2;                %   以上得到交叉数cn的值
        if cn == 1
            b(i,j) = 1;             %   端点
        end
        if cn == 3
            c(i,j) = 1;             %   交叉点
        end
    end
end

a = im2uint8(a);
a = cat(3,a,a,a);                   % 原图变成3通道的rgb图

b = imdilate(b,se) - b;             % 把端点膨胀后得到在减去原端点，得到“空心的圈”
b = im2uint8(b);
b0 = zeros(size(b));
b0 = im2uint8(b0);
b = cat(3,b0,b,b0);                 % 把仅有端点空心圈的灰度图变为rgb图，r、b分量都是全0，仅留下绿色圈

c = imdilate(c,se) - c;             % 把交叉点膨胀后得到在减去原交叉点，得到“空心的圈”
c = im2uint8(c);
c0 = zeros(size(c));
c0 = im2uint8(c0);
c = cat(3,c,c0,c);                  % 把仅有交叉点空心圈的灰度图变为rgb图，g分量是全0，留下r、b分量，显紫色圈


figure(1),
ax(1)=subplot(1,3,1); imshow(a); title('Origin');
ax(2)=subplot(1,3,2); imshow(b); title('Endpoint');
ax(3)=subplot(1,3,3); imshow(c); title('Bifurcation');

linkaxes(ax);

figure, imshow(b);
figure, imshow(c);

imwrite(b,'Endpoint.bmp');
imwrite(c,'Bifurcation.bmp');

res = a + b + c;                    % 将2种细节点的圈图加到原图上，呈现非常美丽的效果
figure,imshow(res,[]),title('Green for Endpoints, Purple for Bifurcation');
imwrite(res,'FingerPrint_Final.bmp');

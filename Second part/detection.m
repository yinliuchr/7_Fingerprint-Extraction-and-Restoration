clear
close all;

a = imread('f_thin.bmp');
b = false(size(a));                 % b �����洢�˵�
c = b;                              % c �����洢�����

se = strel('disk',2);               % ����������ҳ���ϸ�ڵ�����͵ĽṹԪ��

for i = 2:size(a,1)-1
    for j = 2:size(a,2)-1
        if a(i,j) == 0
            continue;               % �˵�ͽ����һ����ָ���ϵĵ㣬������ȥ0���ص�
        end
        cn = abs( a(i-1,j)-a(i-1,j-1)); 
        cn = cn + abs(a(i-1,j+1)-a(i-1,j));
        cn = cn + abs(a(i,j+1)-a(i-1,j+1));
        cn = cn + abs(a(i+1,j+1)-a(i,j+1));
        cn = cn + abs(a(i+1,j)-a(i+1,j+1));
        cn = cn + abs(a(i+1,j-1)-a(i+1,j));
        cn = cn + abs(a(i,j-1)-a(i+1,j-1));
        cn = cn + abs(a(i-1,j-1)-a(i,j-1));
        cn = cn / 2;                %   ���ϵõ�������cn��ֵ
        if cn == 1
            b(i,j) = 1;             %   �˵�
        end
        if cn == 3
            c(i,j) = 1;             %   �����
        end
    end
end

a = im2uint8(a);
a = cat(3,a,a,a);                   % ԭͼ���3ͨ����rgbͼ

b = imdilate(b,se) - b;             % �Ѷ˵����ͺ�õ��ڼ�ȥԭ�˵㣬�õ������ĵ�Ȧ��
b = im2uint8(b);
b0 = zeros(size(b));
b0 = im2uint8(b0);
b = cat(3,b0,b,b0);                 % �ѽ��ж˵����Ȧ�ĻҶ�ͼ��Ϊrgbͼ��r��b��������ȫ0����������ɫȦ

c = imdilate(c,se) - c;             % �ѽ�������ͺ�õ��ڼ�ȥԭ����㣬�õ������ĵ�Ȧ��
c = im2uint8(c);
c0 = zeros(size(c));
c0 = im2uint8(c0);
c = cat(3,c,c0,c);                  % �ѽ��н�������Ȧ�ĻҶ�ͼ��Ϊrgbͼ��g������ȫ0������r��b����������ɫȦ


figure(1),
ax(1)=subplot(1,3,1); imshow(a); title('Origin');
ax(2)=subplot(1,3,2); imshow(b); title('Endpoint');
ax(3)=subplot(1,3,3); imshow(c); title('Bifurcation');

linkaxes(ax);

figure, imshow(b);
figure, imshow(c);

imwrite(b,'Endpoint.bmp');
imwrite(c,'Bifurcation.bmp');

res = a + b + c;                    % ��2��ϸ�ڵ��Ȧͼ�ӵ�ԭͼ�ϣ����ַǳ�������Ч��
figure,imshow(res,[]),title('Green for Endpoints, Purple for Bifurcation');
imwrite(res,'FingerPrint_Final.bmp');

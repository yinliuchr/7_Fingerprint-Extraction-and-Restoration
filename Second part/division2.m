clear
close all;

f = imread('real_part.bmp');

f = im2bw(f,0.5);
f = imcomplement(f);                    %   ת���ɺڱ������߼���ֵͼ

b = 10;

se1 = direction_line(7,b);
se2 = direction_line(7,b);               %   ���Զ����direction_line��������2���ṹԪ��

f_division = zeros(size(f));

for i = 1:b
    fo(:,:,i) = imdilate(imerode(f,se1(i)),se2(i));     % ��һ����ʴ�����͵Ĺ��̣������Ƚϵ��Σ�2���ṹԪ���õ���һ���ģ������൱�ڿ�����
    f_division = max(f_division, fo(:,:,i));            % ��ÿ����������ȡ������Ϣ�������
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
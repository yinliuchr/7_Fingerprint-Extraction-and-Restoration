function se = direction_line(a,b)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:b
    se(i) = strel('line', a, 180 / b * (i - 1));              % ȡb���ȽǶȷ���ֲ������ͽṹԪ�أ� aΪ�䳤��
end

end


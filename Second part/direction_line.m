function se = direction_line(a,b)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:b
    se(i) = strel('line', a, 180 / b * (i - 1));              % 取b个等角度方向分布的线型结构元素， a为其长度
end

end


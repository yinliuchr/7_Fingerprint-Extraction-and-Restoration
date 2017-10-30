function C = Pruning(A, len)

bShow = 1;

B = CreateEndpointSE();
X1 = A;
for k = 1:len
    endpoints = false(size(A));
    for m = 1:size(B,1)
        endpoints = endpoints | bwhitmiss(X1, B{m,1}, B{m,2});      % 用多个结构元素来对A进行击中与否变换，找齐要删的细节点
    end
    X1(endpoints) = 0;                                              % 在原图上让端点像素值归0                           
end

X2 = false(size(A));
for m = 1:size(B,1)
    endpoints = bwhitmiss(X1, B{m,1}, B{m,2});          
    X2(endpoints) = 1;                                              % 仅找出细节点
end

se = strel(ones(3,3));
X3 = X2;

for k = 1:3:Inf
    ori = X3;
    X3 = imdilate(X3, se) & A;                                      % 然后再生长，这样一些多删的点就可恢复
    if X3 == ori
        break;
    end
end

C = X3 | X1;                                                        

%--------------------
function B = CreateEndpointSE()
B{1,1} = [0 0 0; 1 1 0; 0 0 0];
B{1,2} = [0 1 1; 0 0 1; 0 1 1];
for k = 2:4
    B{k,1} = rot90(B{k-1,1});
    B{k,2} = rot90(B{k-1,2});
end

B{5,1} = [1 0 0; 0 1 0; 0 0 0];
B{5,2} = [0 1 1; 1 0 1; 1 1 1];
for k = 6:8
    B{k,1} = rot90(B{k-1,1});
    B{k,2} = rot90(B{k-1,2});
end

B{9,1} = [0 1 0; 0 1 0; 1 0 1];
B{9,2} = [1 0 1; 0 0 0; 0 1 0];
for k = 10:12
    B{k,1} = rot90(B{k-1,1});
    B{k,2} = rot90(B{k-1,2});               % 这里多加了4个结构元素，希望用来去除一些类似“桥接”的东西
end

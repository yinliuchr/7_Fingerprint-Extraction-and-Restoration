function C = Pruning(A, len)

bShow = 1;

B = CreateEndpointSE();
X1 = A;
for k = 1:len
    endpoints = false(size(A));
    for m = 1:size(B,1)
        endpoints = endpoints | bwhitmiss(X1, B{m,1}, B{m,2});      % �ö���ṹԪ������A���л������任������Ҫɾ��ϸ�ڵ�
    end
    X1(endpoints) = 0;                                              % ��ԭͼ���ö˵�����ֵ��0                           
end

X2 = false(size(A));
for m = 1:size(B,1)
    endpoints = bwhitmiss(X1, B{m,1}, B{m,2});          
    X2(endpoints) = 1;                                              % ���ҳ�ϸ�ڵ�
end

se = strel(ones(3,3));
X3 = X2;

for k = 1:3:Inf
    ori = X3;
    X3 = imdilate(X3, se) & A;                                      % Ȼ��������������һЩ��ɾ�ĵ�Ϳɻָ�
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
    B{k,2} = rot90(B{k-1,2});               % ��������4���ṹԪ�أ�ϣ������ȥ��һЩ���ơ��Žӡ��Ķ���
end

function J = MagnifyAndGrid(I, a)
% Jianjiang Feng
% 2016-11-18
I = double(~I);
I(I==0) = 0.7;% for consistent with DIP Book
J = imresize(I, a, 'nearest');
J(1,:) = 0;
for r = 1:size(I,1)
    J(r*a,:) = 0;
end
J(:,1) = 0;
for c = 1:size(I,2)
    J(:,c*a) = 0;
end
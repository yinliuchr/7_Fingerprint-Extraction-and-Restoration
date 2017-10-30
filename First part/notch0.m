%notch
f = imread('fingerprint.bmp');
f = im2double(f);
[M,N] = size(f);
P = max(2*[M N]);% Padding size. 
F = fftshift(fft2(f,P,P));

close all
figure(1),imshow(f,[]);
figure(2),imshow(log(1+abs(F)),[]);

% Creat 4 pairs of notch reject filters
p = [904 690; 1008 580; 1112 470; 1216 360;1320 250];% locations of maxima, found by imtool
H = ones(P,P);
[DX, DY] = meshgrid(1:P);
D0 = 20;
for k = 1:5
    Dk1 = sqrt((DX-p(k,1)).^2+(DY-p(k,2)).^2);
    Dk2 = sqrt((DX-P-2+p(k,1)).^2+(DY-P-2+p(k,2)).^2);
    H1 = 1./(1+(D0./Dk1).^(2*n));
    H2 = 1./(1+(D0./Dk2).^(2*n));
    H = H.*H1.*H2;
end
figure(3),imshow(H,[]);

% Filtering
G = H.*F;
g = real(ifft2(ifftshift(G)));
g = g(1:M,1:N);

figure(4),imshow(log(1+abs(G)),[]);
figure(5),imshow(g,[]);
imwrite(g,'halfway.bmp');
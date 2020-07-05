load map100.mat
n=100;m=100;
M=[];
I=I(2:n+1,2:m+1);
R=R(2:n+1,2:m+1);
Mi=Mi(2:n+1,2:m+1);

I=I+(R-1)*300+(Mi-1)*2000;
for i=1:n
    Mj=[];
    for j=1:m        
        Mj=[ Mj imread( [num2str( I(i,j) ) '.jpg'] ) ];
    end
    M=[M;Mj];
end

%imshow(M);
X=['exampls\0_map_' num2str(n) 'x' num2str(m) '_' num2str(count) '.jpg'];
imwrite(M, X);
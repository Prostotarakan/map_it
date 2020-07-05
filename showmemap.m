function M = showmemap(I, A)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
M=[];
[n m]=size(I);
if nargin==1
for i=1:n
    Mj=[];
    for j=1:m        
        Mj=[ Mj imread( ['parts\' num2str( I(i,j) ) '.jpg'] ) ];
    end
    M=[M;Mj];
end
else
  for i=2:n-1
    Mj=[];
    for j=2:m-1        
        Mj=[ Mj imread( ['parts\' num2str( I(i,j) ) '.jpg'] ) ];
    end
    M=[M;Mj];
  end  
  i=1; Mj=[];
  for j=2:m-1
      Mj=[ Mj imread( [ 'wall\'  num2str( I(i,j) ) '.jpg'] ) ];
  end
  M=[Mj;M];
  i=n; Mj=[];
  for j=2:m-1
      Mj=[ Mj imread( [ 'wall\'  num2str( I(i,j) ) '.jpg'] ) ];
  end
  M=[M;Mj];
  j=1; Mj=[];
  for i=2:n-1
      Mj=[ Mj; imread( [ 'wall\'  num2str( I(i,j) ) '.jpg'] ) ];
  end
  
  j=m; Mi=[];
  for i=2:n-1
      Mi=[ Mi; imread( [ 'wall\'  num2str( I(i,j) ) '.jpg'] ) ];
  end
  
  Mcor1=imread( [ 'corner\'  num2str( I(1,1) ) '.jpg'] );
  Mcor2=imread( [ 'corner\'  num2str( I(1,m)) '.jpg'] );
  Mcor3=imread( [ 'corner\'  num2str( I(n,m)) '.jpg'] );
  Mcor4=imread( [ 'corner\'  num2str( I(n,1)) '.jpg'] );
  
  M=[[Mcor1; Mj; Mcor4] M [Mcor2; Mi; Mcor3]];
end
     
end


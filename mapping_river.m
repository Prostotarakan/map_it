%with river

load('Riv5.mat');
Rivn=5;

n=5;
m=5;

counter=counter+1;

N=22;
Nr=10;
I=zeros(n+2,m+2);
R=ones(n+2,m+2);
Mi=ones(n+2,m+2);

i=2;
j=randi(n)+1;
h=zeros(n*Rivn+Rivn*2,m*Rivn+Rivn*2);

I(i,j)=randi(Nr)+N-Nr;
R(i,j)=randi(4);
Mi(i,j)=randi(2);
c=I(i,j)+(R(i,j)-1)*N+(Mi(i,j)-1)*N*4;
Jj=J(:,:,c);
%I(i,j)=I(i,j)+(R(i,j)-1)*300+(Mi(i,j)-1)*2000;

h((i*Rivn-(Rivn-1)):(i*Rivn),(j*Rivn-(Rivn-1)):(j*Rivn))=Jj;
b=1; count=0;

starter=1;
while starter==1 && count<1000
    
    I1=I+(R-1)*300+(Mi-1)*2000;
    M = showmemap(I1);
    imshow(M);
    
count=count+1;
[x y]=find(h((Rivn+2):(n*Rivn-1+Rivn),(Rivn+2):(m*Rivn-1+Rivn))==1);
x=x+Rivn+1;y=y+Rivn+1; c=1; b=1;
while c==1 && b<=length(x)
    
    if (h((x(b)-1),y(b))+h((x(b)+1),y(b))+h(x(b),(y(b)-1))+h(x(b),(y(b)+1)))==0
        c=0; x=x(b);y=y(b);
    else
        b=b+1;
    end
end

if length(x)==1
    %определение новых i,j, согласно реке
    if mod(x,Rivn)==1
        i=fix(x/Rivn);
        j=fix(y/Rivn)+1;
        ir=Rivn;
        jr=mod(y,Rivn);
        if jr==0
            jr=Rivn;
        end;
    elseif mod(x,Rivn)==0
        i=fix(x/Rivn)+1;
        j=fix(y/Rivn)+1;
        ir=1;
        jr=mod(y,Rivn);
        if jr==0
            jr=Rivn;
        end;
    elseif mod(y,Rivn)==1
        i=fix(x/Rivn)+1;
        j=fix(y/Rivn);
        jr=Rivn;
        ir=mod(x,Rivn);
        if ir==0
            ir=Rivn;
        end;
    elseif mod(y,Rivn)==0
        i=fix(x/Rivn)+1;
        j=fix(y/Rivn)+1;
        jr=1;
        ir=mod(x,Rivn);
        if ir==0
            ir=Rivn;
        end;
    end
    

    f=h(Rivn*i-Rivn:Rivn*i+1,Rivn*j-Rivn:Rivn*j+1);
    Jjr=[f(1,2:(Rivn+1));f(3:Rivn,1) zeros(Rivn-2) f(3:Rivn,(Rivn+2));f((Rivn+2),2:(Rivn+1))];


        d=[];
        for ij=1:length(J)
            if Jjr.*J(:,:,ij)==Jjr
                d=[d;ij];
            end
        end
        if d
            ij=randi(length(d));
            ij=d(ij);
        if ij<=N
            I(i,j)=ij;
            R(i,j)=1;
            Mi(i,j)=1;
        elseif ij<=N*2
            I(i,j)=ij-N;
            R(i,j)=2;
            Mi(i,j)=1;
        elseif ij<=N*3
            I(i,j)=ij-N*2;
            R(i,j)=3;
            Mi(i,j)=1;
        elseif ij<=N*4
            I(i,j)=ij-N*3;
            R(i,j)=4;
            Mi(i,j)=1;
        elseif ij<=N*5
            I(i,j)=ij-N*4;
            R(i,j)=1;
            Mi(i,j)=2;
        elseif ij<=N*6
            I(i,j)=ij-N*5;
            R(i,j)=2;
            Mi(i,j)=2;
        elseif ij<=N*7
            I(i,j)=ij-N*6;
            R(i,j)=3;
            Mi(i,j)=2;
        elseif ij<=N*8
            I(i,j)=ij-N*7;
            R(i,j)=4;
            Mi(i,j)=2;
        end
        h((i*Rivn-Rivn+1):(i*Rivn),(j*Rivn-Rivn+1):(j*Rivn))=J(:,:,ij);    
        else 
            starter=0;
            I=zeros(n+2,m+2);
            h=zeros(n*Rivn+Rivn*2,m*Rivn+Rivn*2);
        end

else
    starter=0;
end
end
M=[];
I=I(2:n+1,2:m+1);
R=R(2:n+1,2:m+1);
Mi=Mi(2:n+1,2:m+1);

s=find (I==0);
I(s)=randi((N-Nr-2),[length(s) 1])+2;
R(s)=randi(4,[length(s) 1]);
Mi(s)=randi(2,[length(s) 1]);

I=I+(R-1)*300+(Mi-1)*2000;

M = showmemap(I);
imshow(M);
X=['exampls\' num2str(counter) '_map_' num2str(n) 'x' num2str(m) '.jpg'];
imwrite(M, X);    
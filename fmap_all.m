function counter = fmap_all(n,m,counter,town, walls, showme)

% town 1 - без рек, 2 - москва, 3 - спб (оптимум), 4 - венеция
% walls 0 - без стен, 1 - стены есть
% showme 0 - без картинок, 1 - с картинками
warning('off');
Rivn=5;
Nw=7;
if town==1
    %counter=fmapping(n,m,counter);
    N=12; Nr=0;
elseif town==2
    load('Riv5_23.mat');
    N=23; Nr=N-12;
elseif town>=3
    load('Riv5_27.mat');
    N=27; Nr=N-12;  
end
if walls==1
    load ('Riv5_w.mat');
end

counter=counter+1;
I=zeros(n+2,m+2);
R=ones(n+2,m+2);
Mi=ones(n+2,m+2);
h=zeros(n*Rivn+Rivn*2,m*Rivn+Rivn*2);

if town>1
    i=randi(n)+1;
    j=randi(m)+1;
    I(i,j)=randi(Nr)+N-Nr;
    R(i,j)=randi(4);
    Mi(i,j)=randi(2);
    c=I(i,j)+(R(i,j)-1)*N+(Mi(i,j)-1)*N*4;
    Jj=J(:,:,c);
    h((i*Rivn-(Rivn-1)):(i*Rivn),(j*Rivn-(Rivn-1)):(j*Rivn))=Jj;
end
    
b=1; count=0;
starter=1;    
 
while starter==1 && count<1000  %река, если имеется.
    if showme==1
        I1=I+(R-1)*300+(Mi-1)*2000;
        M = showmemap(I1);
        imshow(M);
    end
    count=count+1;
    [x y]=find(h==1);
    c=1; b=1;
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
        
        if (i==1 || i==n+2 || j==1 || j==m+2)  %стена
            if (walls==1)
                %%
                if i==1
                    i1=Rivn*(i-1)+1; i2=Rivn*i;
                    j1=Rivn*(j-1)+1; j2=Rivn*j;    
                    Jjr=[0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 h(i2+1,j1+1) 0 h(i2+1,j2-1) 0];
                elseif i==n+2
                    i1=Rivn*(i-1)+1; i2=Rivn*i;
                    j1=Rivn*(j-1)+1; j2=Rivn*j; 
                    Jjr=[ 0 h(i1-1,j1+1) 0 h(i1-1,j2-1) 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0];
                elseif j==1
                    i1=Rivn*(i-1)+1; i2=Rivn*i;
                    j1=Rivn*(j-1)+1; j2=Rivn*j;
                    Jjr=[0 0 0 0 0; 0 0 0 0 h(i1+1,j2+1); 0 0 0 0 0; 0 0 0 0 h(i2-1,j2+1); 0 0 0 0 0];
                elseif j==m+2
                    i1=Rivn*(i-1)+1; i2=Rivn*i;
                    j1=Rivn*(j-1)+1; j2=Rivn*j;
                    Jjr=[0 0 0 0 0; h(i1+1,j1-1) 0 0 0 0; 0 0 0 0 0; h(i2-1,j1-1) 0 0 0 0; 0 0 0 0 0];
                end
                d=[];
                for ij=1:length(Jw)
                    if Jjr.*Jw(:,:,ij)==Jjr
                        d=[d;ij];
                    end
                end
                ij=randi(length(d));
                ij=d(ij);
                if ij<=Nw
                    I(i,j)=ij;
                    R(i,j)=1;
                    Mi(i,j)=1;
                elseif ij<=Nw*2
                    I(i,j)=ij-Nw;
                    R(i,j)=2;
                    Mi(i,j)=1;
                elseif ij<=Nw*3
                    I(i,j)=ij-Nw*2;
                    R(i,j)=3;
                    Mi(i,j)=1;
                elseif ij<=Nw*4
                    I(i,j)=ij-Nw*3;
                    R(i,j)=4;
                    Mi(i,j)=1;
                elseif ij<=Nw*5
                    I(i,j)=ij-Nw*4;
                    R(i,j)=1;
                    Mi(i,j)=2;
                elseif ij<=Nw*6
                    I(i,j)=ij-Nw*5;
                    R(i,j)=2;
                    Mi(i,j)=2;
                elseif ij<=Nw*7
                    I(i,j)=ij-Nw*6;
                    R(i,j)=3;
                    Mi(i,j)=2;
                elseif ij<=Nw*8
                    I(i,j)=ij-Nw*7;
                    R(i,j)=4;
                    Mi(i,j)=2;
                end
                h(i1:i2,j1:j2)=Jw(:,:,ij); 
            else
                h(x,y)=0;
            end  
        else
            f=h(Rivn*i-Rivn:Rivn*i+1,Rivn*j-Rivn:Rivn*j+1);
            Jjr=[f(1,2:(Rivn+1));f(3:Rivn,1) zeros(Rivn-2) f(3:Rivn,(Rivn+2));f((Rivn+2),2:(Rivn+1))];
            d=[];
            for ij=1:length(J)
                if Jjr.*J(:,:,ij)==Jjr
                    d=[d;ij];
                end
            end
            if d
                if ((length(find(mod(d,N)>=23)) + length(find(mod(d,N)==0)))==length(d)) || town==4
                    ij=randi(length(d));
                    ij=d(ij);
                else
                    di=find(mod(d,N)<23 & mod(d,N)>0);
                    ij=randi(length(di));
                    ij=d(di(ij));
                end;
                
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
            
            
        end
        else
            starter=0;
        end
end


[x y]=find (I(2:n+1,2:m+1)==0);x=x+1; y=y+1; 
for ki=1:length(x)
    i=x(ki);j=y(ki);
    I(i,j)=randi((N-Nr));
    R(i,j)=randi(4);
    Mi(i,j)=randi(2);
end
[x y]=find(I(2:n+1,2:m+1)<=2);x=x+1; y=y+1;
for ki=1:length(x)
    i=x(ki);j=y(ki);
    kj=find(I(i:i+1,j:j+1)>12);
    if length(kj)>=1 || i==n+1 || j==m+1
        I(i,j)=randi((N-Nr-2))+2;
    else
        g=I(i-1:i+1,j-1:j+1);
        g=find(g<=2);
        if length(g)>1
            I(i,j)=randi(N-Nr-2)+2;
        else
            if I(i,j)==1
                if Mi(i,j)==1
                    if R(i,j)==1
                       I(i+1,j)=102;
                       R(i+1,j)=1;
                       Mi(i+1,j)=1;
                    elseif R(i,j)==2
                       I(i,j+1)=102;
                       R(i,j+1)=2;
                       Mi(i,j+1)=1;
                    elseif R(i,j)==3
                       I(i,j)=102; 
                       I(i+1,j)=1;
                       R(i+1,j)=3;
                       Mi(i+1,j)=1;
                    elseif R(i,j)==4
                       I(i,j)=102;
                       I(i,j+1)=1;
                       R(i,j+1)=4;
                       Mi(i,j+1)=1;
                    end
                else
                    if R(i,j)==1
                       I(i+1,j)=102;
                       R(i+1,j)=1;
                       Mi(i+1,j)=2;
                    elseif R(i,j)==4
                       I(i,j+1)=102;
                       R(i,j+1)=4;
                       Mi(i,j+1)=2;
                    elseif R(i,j)==3
                       I(i,j)=102; 
                       I(i+1,j)=1;
                       R(i+1,j)=3;
                       Mi(i+1,j)=2;
                    elseif R(i,j)==2
                       I(i,j)=102;
                       I(i,j+1)=1;
                       R(i,j+1)=2;
                       Mi(i,j+1)=2;
                    end
                end
            end
            if I(i,j)==2
                Mi(i:i+1,j:j+1)=Mi(i,j);
                R(i:i+1,j:j+1)=R(i,j);
                if Mi(i,j)==1
                    if R(i,j)==1
                        I(i,j)=2;
                        I(i,j+1)=202;
                        I(i+1,j)=203;
                        I(i+1,j+1)=204;
                    elseif R(i,j)==2
                        I(i,j)=202;
                        I(i,j+1)=204;
                        I(i+1,j)=2;
                        I(i+1,j+1)=203;
                    elseif R(i,j)==3
                        I(i,j)=204;
                        I(i,j+1)=203;
                        I(i+1,j)=202;
                        I(i+1,j+1)=2;
                    elseif R(i,j)==4
                        I(i,j)=203;
                        I(i,j+1)=2;
                        I(i+1,j)=204;
                        I(i+1,j+1)=202;
                    end
                else
                    if R(i,j)==1
                        I(i,j)=202;
                        I(i,j+1)=2;
                        I(i+1,j)=204;
                        I(i+1,j+1)=203;
                    elseif R(i,j)==2
                        I(i,j)=204;
                        I(i,j+1)=202;
                        I(i+1,j)=203;
                        I(i+1,j+1)=2;
                    elseif R(i,j)==3
                        I(i,j)=203;
                        I(i,j+1)=204;
                        I(i+1,j)=2;
                        I(i+1,j+1)=202;
                    elseif R(i,j)==4
                        I(i,j)=2;
                        I(i,j+1)=203;
                        I(i+1,j)=202;
                        I(i+1,j+1)=204;
                    end
                end
            end
        end
    end
end
I(2:n+1,2:m+1)=I(2:n+1,2:m+1)+(R(2:n+1,2:m+1)-1)*300+(Mi(2:n+1,2:m+1)-1)*2000;

if walls==0
    I=I(2:n+1,2:m+1);
    R=R(2:n+1,2:m+1);
    Mi=Mi(2:n+1,2:m+1);
    
    M=showmemap(I);
else
    I1=I(2:n+1,2:m+1);
    I=I+(R-1)*20+(Mi-1)*100;
    I(2:n+1,2:m+1)=I1;
    
    [x y]=find (I==0);
    for ki=1:length(x)
        i=x(ki);j=y(ki);
        if j==1
            I(i,j)=randi(4)+(randi(2)-1)*140;
        elseif j==m+2
            I(i,j)=randi(4)+40+(randi(2)-1)*60;
        elseif i==1
            I(i,j)=randi(4)+60+(randi(2)-1)*100;
        elseif i==n+2
            I(i,j)=randi(4)+20+(randi(2)-1)*100;
        end
    end
    
    I(1,1)=randi(6)+60+(randi(2)-1)*80;
    I(1,m+2)=randi(6)+40+(randi(2)-1)*120;
    I(n+2,m+2)=randi(6)+20+(randi(2)-1)*80;
    I(n+2,1)=randi(6)+0+(randi(2)-1)*120;
    
    M=showmemap(I,1);
end

if showme>=1
    imshow(M);    
end

X=['exampls\' num2str(counter) '_map_' num2str(n) 'x' num2str(m) '.jpg'];
imwrite(M, X);
end


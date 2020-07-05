function count = fmapping(n,m,count,showme)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
count=count+1;

N=12;

I=ones(n+2,m+2)*3;
R=ones(n+2,m+2);
Mi=ones(n+2,m+2);
I(2:n+1,2:m+1)=randi(N,[n m]);
R(2:n+1,2:m+1)=randi(4,[n m]);
Mi(2:n+1,2:m+1)=randi(2,[n m]);


[x y]=find(I<=2);

for ki=1:length(x)
    i=x(ki);j=y(ki);
    g=I(i-1:i+1,j-1:j+1);
    g=find(g<=2);
    if length(g)>1
        I(i,j)=randi(N-2)+2;
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

        
        
M=[];
I=I(2:n+1,2:m+1);
R=R(2:n+1,2:m+1);
Mi=Mi(2:n+1,2:m+1);

I=I+(R-1)*300+(Mi-1)*2000;

M = showmemap(I);

if showme>=1
    imshow(M);
end

X=['exampls\' num2str(count) '_map_' num2str(n) 'x' num2str(m) '.jpg'];
imwrite(M, X);
end


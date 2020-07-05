count=10;

n=10;
m=15;
N=12;

I=zeros(n+1,m+1);
R=I;
Mi=I;
M=[];
for i=1:n
    Mj=[];
    for j=1:m
        if I(i,j)==0
            I(i,j)=randi(N);
            R(i,j)=randi(4);
            Mi(i,j)=randi(2);
            if I(i,j)==7 && randi(2)==2
                I(i,j)=randi(N);
            end
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
        if Mi(i,j)==2 
            Mj=[Mj flipdim(imrotate(imread([num2str(I(i,j)) '.jpg']), (R(i,j)-1)*90), Mi(i,j))    ];
        else
            Mj=[Mj imrotate(imread([num2str(I(i,j)) '.jpg']), (R(i,j)-1)*90)    ];
        end        
    end
    M=[M;Mj];
end
I=I(1:n,1:m);
R=R(1:n,1:m);
Mi=Mi(1:n,1:m);
imshow(M);
% X=['exampls\0_map_' num2str(n) 'x' num2str(m) '_' num2str(count) '.jpg'];
% imwrite(M, X);
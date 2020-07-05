
N=7; 
for i=1:N
    I=imread(['wall\' num2str(i) '.jpg']);
    imshow(I)
    J=[0 0 0 0 0;0 0 0 0 0;0 0 0 0 0;0 0 0 0 0;0 0 0 0 0];
    if sum(I(120,250,:))<255*3
        J(2,5)=1;
    end
    if sum(I(370,250,:))<255*3
        J(4,5)=1;
    end
    Jw(:,:,i)=J;
end

   
J1=rot90(Jw);
J2=rot90(J1);
J3=rot90(J2); 
Jw(:,:,(N+1):2*N)=J1;
Jw(:,:,(2*N+1):3*N)=J2;
Jw(:,:,(3*N+1):4*N)=J3;
Jw(:,:,(4*N+1):8*N)=flipdim(Jw,2);

save Riv5_w Jw
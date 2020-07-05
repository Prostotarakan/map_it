D=[1;2;3;4;5;6];

plase='corner\';
for i=1:length(D)
    I=imread([plase num2str(D(i)) '.jpg']);
    imwrite( rot90(I),[plase num2str(D(i)+20) '.jpg']);
    imwrite( rot90(rot90(I)),[plase num2str(D(i)+40) '.jpg']);
    imwrite( rot90(rot90(rot90(I))),[plase num2str(D(i)+60) '.jpg']);
    imwrite( flipdim( I,2),[plase num2str(D(i)+100) '.jpg']);
    imwrite( flipdim( rot90(I),2),[plase num2str(D(i)+120) '.jpg']);
    imwrite( flipdim( rot90(rot90(I)),2),[plase num2str(D(i)+140) '.jpg']);
    imwrite( flipdim( rot90(rot90(rot90(I))),2),[plase num2str(D(i)+160) '.jpg']);
end
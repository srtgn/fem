
x=input('Give me "1" for Hinge & "2" for Fixed support :');

a=input('a:');


if x==1;
    
bc=ones(((a+1)*3),1);
bc(1:3:((a+1)*3),1)=0;
bc(2:3:((a+1)*3),1)=0;
bc(3:3:((a+1)*3),1)=[];
disp(bc);

n=ones(((a+1)*3),1);
n(:,1)=1:(a+1)*3;
n(3:3:((a+1)*3),1)=[];

else 
    bc=zeros(((a+1)*3),1);
    n=ones(((a+1)*3),1);
    
n(:,1)=1:(a+1)*3;
disp(n);
end;

bc=[n,bc];
disp(bc);

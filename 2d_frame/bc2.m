x=input('Give me "1" for Hinge & "2" for Fixed support :');
a=input('a :');

n=ones(((a+1)*3),1);
n(:,1)=1:(a+1)*3;
disp(n);

if x==1;

    bc1=(1:3:((a+1)*3));
    
    bc3=(2:3:((a+1)*3));
    

bc=[bc1,bc3];
bc=sort(bc);
    n=zeros(((a+1)*2),1);
    disp(n);
    bc=bc';
else 
    bc=ones(((a+1)*3),1);
    bc(:,1)=1:(a+1)*3;
    n=zeros(((a+1)*3),1);
    disp(n);
end;

disp(bc);

bc=[bc,n];
disp(bc);
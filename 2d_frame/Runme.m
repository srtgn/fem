
% 2D frame FEM code
% Created on April 10, 2013
% @author: Saeed Rastegarian of IAU


% ------- Producing INPUTS ---------%
a=input('Give me span number :');
b=input('Give me the span lenght :');
c=input('Give me story number :');
d=input('Give me the story height :');
e=3*(a+1)*(c+1);

% -------coordinates matrix-------%
h=zeros(a+1,1);
h(:,1)=0:b:a*b;
g=repmat(h,c+1,1);

i=zeros(c+1,1);
i(:,1)=0:d:d*c;
j=repmat(i,a+1,1);
k=sort(j);

coord=[g,k];
     
% -------Degrees Of Freedom Matrix-------%
DOF=ones((e/3),3);
DOF(:,1)=(1:3:(e-2));
DOF(:,2)=(2:3:(e-1));
DOF(:,3)=(3:3:(e));


% -------Elements Degrees Of Freedom Matrix (EDOF)-------%

%----------------]
%Columns EDOF    ]
%----------------]

t=zeros(c,a+1);

for i=1:a+1;
    t(:,i)=i:a+1:((a+1)*(c));
end;

h1=zeros((a+1)*(c),1);
for i=(a+1)*(c);
    for j=(a+1)*(c);
    h1(1:i)=t(1:j);
    end;
end;

l1=h1(:,1)-1;
z1=l1*2;
x1=z1+h1;
v1=[x1,x1+1,x1+2];disp(v1);

g1=h1+a+1;
l2=g1(:,1)-1;disp(l2);
z2=l2*2;
x2=z2+g1;
v2=[x2,x2+1,x2+2];disp(v2)
k1=[v1,v2];

%----------------]
%Beams EDOF      ]
%----------------]
 
t1=zeros(c+1,a+1);
for i=1:a+1;
    t1(:,i)=i:a+1:((a+1)*(c+1));
end;
t1(1,:)=[];
t1(:,a+1)=[];

h2=zeros((a)*(c),1);
for i=(a)*(c);
    for j=(a)*(c);
    h2(1:i)=t1(1:j);
    end;
end;

g2=h2+1;
k2=[h2,g2];
 
l3=h2(:,1)-1;
z3=l3*2;
x3=z3+h2;
v3=[x3,x3+1,x3+2];

g3=h2(:,1)+1;
l4=g3(:,1)-1;disp(l4);
z4=l4*2;
x4=z4+g3;
v4=[x4,x4+1,x4+2];
k3=[v3,v4];

%-------Combining Columns EDOF & BEAMS EDOF-------%
n=zeros((c*(a+1)+(c*a)),1);
for i=1:(c*(a+1)+(c*a));n(i)=i;
end;

m=[k1;k3];

EDOF=[n,m];
         
% --------- Create and assemble element matrices ---------%
[Ex,Ey]=coordxtr(EDOF,coord,DOF,2);


ep=[200e9 2e-3 1.6e-5];
input(' ep = [E A I] :');
eldraw2(Ex,Ey,[1,1,1]);

% --------- Load matrix----------%
eq=zeros(1,2);
eq(:,2)=input(' q (distributed load):');
eq(:,1)=0;
o=((c+1)*(a+1))*3;
K=zeros(o); f=zeros(o,1);
for i=1:o;
    f(i)=0;
end
% f(7)=2000;

for i=1:((a+1)*c);
   
Ke1=beam2e(Ex(i,:),Ey(i,:),ep);
 K=assem(EDOF(i,:),K,Ke1);
end;

disp('Ke1');
disp(Ke1);
            
for j=(((a+1)*c)+1):((a+1)*c)+(a*c);
               
[Ke2,fe]=beam2e(Ex(j,:),Ey(j,:),ep,eq);
[K,f]=assem(EDOF(j,:),K,Ke2,f,fe);
        
end;


% ---------Defining Boundary Conditions----------%
bc=zeros(((a+1)*3),2);
bc(:,1)=1:(a+1)*3;
bc(:,2)=0;
bc=input('bc :');

% ----- Solve equation system -----
mm=input(' 1 for fixed support - 2 for hing support :');
for i=1:(a+1)*3;
    bc1=[i,0];
end;
if mm==1 
     bc=bc1;
      else
    for j=3:3:(a+1)*3;
         bc(j,:)=1;
    end;
end ;    

% --------- Displacement & Reaction Calculation----------% 
[a,r]=solveq(K,f,bc);
disp(a);

for i=1:3:e;
   x=a(i);
   for i1=2:3:e;
       y=a(i1);
       for i2=3:3:e;
           r=a(i2);
       end
   end
end
nn=[x,y,r];
disp(' x   y   r:');
disp(nn);

% --------- Display Results----------%  
Ed=extract(EDOF,a);

sfac=scalfact2(Ex,Ey,Ed,.1);
eldisp2(Ex,Ey,Ed,[2 2 1],sfac);

%%%%%%%%      
%end%%%%
%%%%%%%%        

  
  
function [qws,qwf]=lisse1(Lx,Ly,e,b,table2,table3)
%qws side wall qwf front
lf=Lx/4;t=Ly/4;bl=1;%m  
La=e/5;
if b==Ly
L=lf;
elseif b==Lx
L=t;
end
Lb=L-La;
sd=L*bl;sa=La*bl;sb=Lb*bl;
Twall=fepf1();
sw=[sd,0,0,sa,sb];n=length(sw)+1;cd=[1;0;0;1;1];qw=zeros(n-1,1);
epf=depf(n,Twall,sw);
we=fwe(epf,sw,table2);
wi=table3{1:n-1,5};blm=[1;0;0;1;1];
for i=1:n-1
qw(i)=(cd(i)*we(i)-wi(i))*blm(i);%daN/ml
end
qwa=qw(4);qwb=qw(5);
qwd=qw(1);qeq=(qwa*La+qwb*Lb)/L;
if L==t %qws side qwf gable
qws=qwd;qwf=qeq;
elseif L==lf
qws=qeq;qwf=qwd;
end
end

%% end
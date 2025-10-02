function [T,qw]=wt4(di,df,si,sf,chI)
%wind truss 
in=readtable(chI,'sheet','T7');
in2=readtable(chI,'sheet','T8');
qpze1=in{1,3};wi1=in2{1,5};
%front of hangar wind2 zoneD
s=zeros(1,5);b=zeros(1,5);
for i=1:5
s(i)=sf(i)-si(i);b(i)=df(i)-di(i);
end
epf1=[1,1,1,1,1];epf10=[0.8,0.8,0.8,0.8,0.8];
qpze=[qpze1,qpze1,qpze1,qpze1,qpze1];wi=[wi1,wi1,wi1,wi1,wi1];
epf=zeros(1,5);we=zeros(1,5);qw=zeros(1,5);
for i=1:5
epf(i)=depf2(epf1(i),epf10(i),s(i));we(i)=qpze(i)*epf(i);qw(i)=(we(i)-wi(i))*b(i)/10;
end
c={'di';'df';'si';'sf';'s';'b';'epf';'qw'};
var={'attributes','M1','M2','M3','M4','M5'};
M=[di;df;si;sf;s;b;epf;qw];
T=table(c,M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),'VariableNames',var);
end
%% end
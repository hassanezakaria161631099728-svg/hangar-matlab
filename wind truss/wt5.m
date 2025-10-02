function [Fwi1,Fwi2,h,val1,val2,iymin,Ld]=wt5(qw1,qw2,ba,key1,key2,l,t)
h3=ba{1,1};h1=h3-2;h2=h3-1;
h=[h1,h2,h3,h2,h1];
Fwi1=zeros(1,5);Fwi2=zeros(1,5);
for i=1:5
Fwi1(i)=qw1(i)*h(i)/2/100;
Fwi2(i)=qw2(i)*h(i)/2/100;
end
keys1=[16 18 20 24];
values1=[36 40 45 50];
val1=keyval(key1,keys1,values1);
keys2=[8 9 11];
values2=[26 28 30];
val2=keyval(key2,keys2,values2);
%dimensionnement des diagonales
Ld=(l^2+t^2)^0.5;%truss diagonal lenght Ldfy=Ld
iymin=Ld/3;%cm
end
%% end
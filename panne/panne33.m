function [combdel,delmax,d2]=panne33(gy,w,Qy,wp,sy)
%ELS bending combinations vector system to clarify operations
del1=[gy;gy;gy;gy]*100;del0=[0;0;0;0];
del2=[w;Qy;sy;wp]*100;
del3=[0;0;0;sy]*100;
n=8;
a=zeros(n,1);lt=strings(n,1);cas=strings(n,1);
for i=1:n
a(i)=1;lt(i)="snow";cas(i)="ELS";
end
V1=[del1;del0];V2=[del2;del2];V3=[del3;del3];
delvals=zeros(4,1);
for i=1:n
delvals(i)=comb(V1(i),V2(i),V3(i),cas{i},a(i),lt{i});
end
c={'G+W-';'G+Q';'G+S';'G+W++0.6*(S/2)';'W-';'Q';'S';'W++0.6*(S/2)'};
var={'comb','Gk','Qk1','Qki','Sser'};
combdel=table(c,V1,V2,V3,delvals,'VariableNames',var);
delmax=max(delvals(1:4));d2=max(delvals(5:8));
end
%% end
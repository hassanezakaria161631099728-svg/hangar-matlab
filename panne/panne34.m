function [com,ysdn,zscorr,ysdp,zsdp]=panne34(gy,gz,w,Qy,sy,wp,Qz,sz)
%ELU
%shear forces and momentum combinations
V1=[gy;gy;gy;gy;gz;gz]*10^5;
V2=[-1*w;Qy;sy;wp;Qz;sz]*10^5;
V3=[0;0;0;sy;0;0]*10^5;
n=length(V1);combVvals=zeros(n,1);
a=zeros(n,1);lt=strings(n,1);cas=strings(n,1);
for i=1:n
a(i)=1;lt(i)="snow";cas(i)="ELU";
combVvals(i)=comb(V1(i),V2(i),V3(i),cas{i},a(i),lt{i});
end
c={'y';'y';'y';'y';'z';'z'};
var={'axis','comb','Gk','Qk1','Qki','Sd'};
c2={'G+1.5W-';'1.35G+1.5Q';'1.35G+1.5S';'1.35G+1.5W++1.5*0.6*(S/2)'
'1.35G+1.5Q';'1.35G+1.5S'};
com=table(c,c2,V1,V2,V3,combVvals,'VariableNames',var);
ysdn=max(combVvals(1:4));zsdp=max(combVvals(5:6));ysdp=max(combVvals(2:3));
zscorr=gz*10^5;
end
%% end
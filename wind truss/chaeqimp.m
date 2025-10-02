function [T2,q,dF1,dF2]=chaeqimp(T,L,cas)
%calcul de la charge equivalente aux imperfections
fy=2350;
if strcmp(cas,'traverse')
h=T{1,2}/100;wply=T{1,18};%ipe
Mcrd=wply*fy/1.1*10^-4;%KN.m
N=Mcrd/h;
T2=table(h,Mcrd,N);
elseif strcmp(cas,'poteau')
[laz,labz,alphaz,phiz,Xiz,N]=flam1(L,'z',T,'simplement appuye',0,0);
T2=table(laz,labz,alphaz,phiz,Xiz,N);
end
kr=(0.2+1/3)^0.5;
q=3*N*(kr+0.2)/(60*L);%KN/ml
if strcmp(cas,'traverse')
lf=L/4;
dF1=q*lf;dF2=dF1/2;
elseif strcmp(cas,'poteau')
dF1=q*L/2;dF2=dF1;
end
end
%% end
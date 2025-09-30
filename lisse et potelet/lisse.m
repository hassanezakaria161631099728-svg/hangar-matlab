function [Tlisse,T2,T3,T4]=lisse(hangarf,chI,beamT)
[Lx,Ly,ba,in1,in2,in3,in6,in7,in8]=lisse0(hangarf,chI);
e1=in1{1,4};e2=in6{1,4};b1=Lx;b2=Ly;lf=Lx/4;t=Ly/4;h2=ba{1,2};
qgb=11.89;%daN
[qws1,qwf1]=lisse1(Lx,Ly,e1,b1,in2,in3);
[qws2,qwf2]=lisse1(Lx,Ly,e2,b2,in7,in8);
%determining the fit UPE 
qws=max(qws1,qws2*-1)/10;qwf=max(qwf1*-1,qwf2)/10;%qw2<0
TUPE=readtable(beamT,'sheet','UPE');
sls=beam3(t,qws,TUPE);slf=beam3(lf,qwf,TUPE);
if sls{1,2}<slf{1,2}
Tlisse=slf;ll=lf;qw=qwf;%T1 table of selected UPE longeur de lisse
disp('lisse du pignon est plus sollicite');
elseif slf{1,2}<sls{1,2}
Tlisse=sls;ll=t;qw=qws;
disp('lisse du longpan est plus sollicite');
end
qgl=Tlisse{1,8};%daN
qg=qgl+qgb;%daN/ml
T2=table(qws1,qwf1,qws2,qwf2,qws,qwf,ll,qw,qgl,qgb,qg);
%actions sur la lisse
lt='uniform';
[Mw,Vw]=MV(lt,'y',qw,ll,1);
[Mg,Vg]=MV(lt,'z',qg,ll,1);
%verifications a ELU
%shear forces
Vysd=1.5*Vw;Vzsd=1.35*Vg;
[Avy,Vplrdy]=fvplrd('y',Tlisse,'UPE',Vysd);
[Avz,Vplrdz]=fvplrd('z',Tlisse,'UPE',Vzsd);
%momentum
Mysd=1.5*Mw;Mzsd=1.35*Mg;
r=resis(Tlisse,Mysd,Mzsd);
T3=table(Vysd,Vzsd,Avy,Vplrdy,Avz,Vplrdz,Mysd,Mzsd,r);
%calcul des liernes liant les lisses
[G1,qsdt1,L1,NT1,Nsd1,beta]=lierlis(h2,qgl,qgb,lf,t,'side');
[G2,qsdt2,L2,NT2,Nsd2]=lierlis(h2,qgl,qgb,lf,t,'front');
Nsd=max(Nsd1,Nsd2);
T4=table(G1,qsdt1,L1,NT1,Nsd1,beta,G2,qsdt2,L2,NT2,Nsd2,Nsd);
end

%% end
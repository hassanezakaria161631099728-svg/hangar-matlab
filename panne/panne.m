function [Tpanne,T2,loads,acp,combdel,combV,combM,T8,T9,T10]=panne(b1,b2,hangarf,chI,beamT)
[ba,geo,Troof1,Troof2,in1,in2,in3,in6,in7,in8]=panne0(hangarf,chI);
bt=ba{1,7};Lx=ba{1,3};Ly=ba{1,4};
s=snow(geo,ba,Ly,Lx,Lx,Ly);
bp=1.355;%largeur d'influence de la panne la plus sollicite a l'extremite
qw1=panne1(ba,bt,b1,Troof1,in1,in2,in3,bp);
qw2=panne1(ba,bt,b2,Troof2,in6,in7,in8,bp);
qws=[qw1;qw2];%N/ml
qw=maxabs(qws)/10;%daN/ml
t=Ly/4;%m
alpha=ba{1,5};
%determination des caracteristiques du profile de la panne
in=readtable(beamT,'sheet','IPE');
[Tpanne,Iymin,lb]=beam3(t,qw,in);%profile IPE pour la panne
%evaluation des charges sur la panne la plus defavorable
qgc=15.21;%daN/m poids de la couverture TL75M
qgp=Tpanne{1,8};%poids propre de la panne
qg=qgp+qgc*bp;%charge permanente
qs=s(1)*bp;%charge de neige
Q=100;%daN=kg live load are note: is not combined with climat loads
T2=table(bp,Iymin,lb,qw1(1),qw1(2),qw2,qg,qs,Q);
%charge sur la panne et combinaisons d'action
qwp=qw1(2)/10;qsy=qs*cosd(alpha);qgy=qg*cosd(alpha);Qy=Q*cosd(alpha);
qsz=qs*sind(alpha);qgz=qg*sind(alpha);Qz=Q*sind(alpha);
var={'axis','Q','qw','qwp','qs','qg'};
loads=table({'y';'z'},[Qy;Qz],[qw;0],[qwp;0],[qsy;qsz],[qgy;qgz],'VariableNames',var);
[acp,combdel,combV,combM,delmax,del2,Vysdn,Vzsdp,Mysdn,Mzscorr,Mysdp,Mzsdp]=panne3(Tpanne,qgy,qgz,qw,Qy,Qz,qwp,qsy,qsz,Ly);
%verification a ELU & ELS
[Avy,Vplrdy]=fvplrd('y',Tpanne,'IPE',Vysdn);
[Avz,Vplrdz]=fvplrd('z',Tpanne,'IPE',Vzsdp);
[lbmax,lb2]=bending(del2,delmax,t);
%resistance
r1=resis(Tpanne,Mysdp,Mzsdp);
var={'delmax','L/200','del2','L/250','Vysd','Avy','Vplrdy','Vzsd','Avz','Vplrdz','Mysdp','Mzsdp','resis'};
T8=table(delmax,lbmax,del2,lb2,Vysdn,Avy,Vplrdy,Vzsdp,Avz,Vplrdz,Mysdp,Mzsdp,r1,'VariableNames',var);
%deversement
fy=2350;
[ult,klt,L1,Lfz,zg,k,c1,c2,lalt,laltb,alphalt,philt,xlt,rd]=dever(t,0,'double fixed',0,1,fy,Tpanne,Mzscorr,1,Mysdn);
%dever(L,lazb,lt,Nsd,xiz,fy,T,Mzscorr,kz,Mysdn)
T9=table(ult,klt,L1,Lfz,zg,k,c1,c2,lalt,laltb,alphalt,philt,xlt,Mysdn,Mzscorr,rd);
%calcul des liernes
T10=lierne(t,qgp,qgc,s(1),alpha,Lx);
end
%% end
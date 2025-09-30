function [T5,Tpotelet,T6,T7,T8,T9]=potelet(TUPE,hangarf,chI,beamT)
[Lx,Ly,ba,in1,in2,in3,in6,in7,in8]=lisse0(hangarf,chI);
e1=in1{1,4};e2=in6{1,4};h1=ba{1,1};h2=ba{1,2};b1=Ly;b2=Lx;
qpze1=in2{1,3};qpze2=in7{1,3};
wi1=in3{1,5};wi2=in8{1,5};
qgb=11.89;%dan
[qwn,sa,sb,bpa,ha]=potelet1(b1,Lx,Ly,e1,qpze1,wi1,h2);
[qwp,sd]=potelet1(b2,Lx,Ly,e2,qpze2,wi2,h2);
qw=max(-1*qwn,qwp);%T6,T7,T8
THEB=readtable(beamT,'sheet','HEB');
[Tpotelet,Iymin,lb]=beam3(h1,qw,THEB);%HEB selectionne pour potelet
T5=table(qwn,bpa,ha,sa,sb,qwp,sd,qw,Iymin,lb);
Vw=qw*h1/2;Vysd=1.5*Vw;
[Avy,Vplrdy]=fvplrd('y',Tpotelet,'HEB',Vysd);
nl=h2;bp=Lx/4;pl=TUPE{1,8};%poids lineaire de la lisse
NGl=nl*bp*pl;%poids des lisses
NGb=(sd-bp*2)*qgb;%poids du bardage 2m de brick qu'on enleve
plp=Tpotelet{1,8};%poids lineaire du potelet
NGp=plp*h1;%poids du poteau
NG=NGl+NGb+NGp;Nsd=1.35*NG;%effort normal de compression
Mwn=-1*qwn*(h1-1)^2/8;Mwp=qw*h1^2/8;Mysdn=1.5*Mwn;Mysdp=1.5*Mwp;
T6=table(Vw,Vysd,Avy,Vplrdy,NGl,NGb,NGp,NG,Nsd,Mysdn,Mysdp);
fy=2350;
%flambement
[lay,layb,alphay,phiy,xiy]=flam1(h1,'y',Tpotelet,'simplement appuye',1,1);
[laz,lazb,alphaz,phiz,xiz]=flam1(h1,'z',Tpotelet,'simplement appuye',1,1);
[uy,ky]=flam2(layb,Tpotelet,Nsd,xiy,fy,'y');
[xmin,rf]=flam3(Nsd,fy,xiy,xiz,ky,Mysdp,Tpotelet);
T7=table(h1,lay,layb,alphay,phiy,xiy,laz,lazb,alphaz,phiz,xiz,Nsd,uy,ky,xmin,rf);
%deversement
[lazd,lazbd,alphazd,phizd,xizd]=flam1(h1-1,'z',Tpotelet,'simplement appuye',1,1);
[ult,klt,L1,Lfz,zg,k,c1,c2,lalt,laltb,alphalt,philt,...
    xlt,rd]=dever(h1-1,lazbd,'simplement appuye',Nsd,1,fy,Tpotelet,0,1,Mysdn);
%dever(L,lazb,lt,Nsd,xiz,fy,T,Mzscorr,kz,Mysdn)
T8=table(h1-1,lazd,lazbd,alphazd,phizd,xizd);
T9=table(Nsd,Mysdn,xizd,ult,klt,L1,Lfz,zg,k,c1,c2,...
lalt,laltb,alphalt,philt,xlt,rd);
end
%% end
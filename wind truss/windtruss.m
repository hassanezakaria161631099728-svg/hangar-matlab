function [T1,T2,Ttrav,Tpot,Tdiag,T6,T7,T8,T9,T10,T11,T12,T13]=windtruss(hangarf,beamT,chI,chII_1)
%wind truss
%on wind 1 direction the front contains negative values b=Ly 
ba=readtable(hangarf,'sheet','building attributes');
Lx=ba{1,3};Ly=ba{1,4};h=ba{1,1};l=Lx/4;t=Ly/4;
e=min(Ly,2*h);
[di,df,dI,dII,dIII,h1,h2,s1,s2,s3]=wt1(ba,e);
[si,sf,ha,hb,sI,sII,sIII]=wt2(s1,s2,s3,dI,dII,ba);
[T1,qw1]=wt3(si,sf,sI,sII,sIII,di,df,dI,dII,dIII,chI);
[T2,qw2]=wt4(di,df,si,sf,chI);
[Fwi1,Fwi2,hi,hipe,hheb,iymin,Ld]=wt5(qw1,qw2,ba,Lx,h,l,t);
TIPE=readtable(beamT,'sheet','IPE');%traverse
THEB=readtable(beamT,'sheet','HEB');%poteau
Tcor=readtable(beamT,'sheet','corniere');%diagonales
Ttrav=beam4(hipe,2,TIPE);%traverse
Tpot=beam4(hheb,2,THEB);%poteau
Tdiag=beam4(iymin,12,Tcor);%diagonale
[T6,q,dF1,dF2]=chaeqimp(Ttrav,Lx,'traverse');
T7=table(h1,h2,ha,hb,q);
[T8,T9,T10,p1,d1,d2,R1,R2]=wt8(Fwi1,Fwi2,hi,dF1,dF2,qw1,qw2,Lx,Ly,Ttrav,Tpot,Tdiag);
in1=readtable(chII_1,'sheet','T9');%poteau
Tpanne=readtable(chII_1,'sheet','Tpanne');%poteau
%verification de la compression des pannes (deversement)
Nsd=min(p1)*-100;%daN
fy=2350;%daN/m_2
[laz,lazb,alphaz,phiz,xiz]=flam1(t,'z',Tpanne,'double fixed',1,1);
[ult,klt]=dever(lazb,Nsd,xiz,fy,Tpanne);
[zg,k,c1,c2,lalt,laltb,philt,xlt]=dever2(t,Tpanne,'double fixed');
[uz,kz]=flam2(lazb,Tpanne,Nsd,xiz,fy,'z');
Mysdn=in1{1,9};Mzscorr=in1{1,10};
r=dever3(Nsd,xiz,fy,klt,Mysdn,xlt,kz,Mzscorr,Tpanne);
T11=table(laz,lazb,alphaz,phiz,xiz,ult,klt,zg,k,c1,c2,lalt,laltb,philt,xlt);
var={'Nsd','uz','kz','Mysdn','Mzscorr','dever'};
T12=table(Nsd,uz,kz,Mysdn,Mzscorr,r,'VariableNames',var);
%verification des diagonales (cornieres) a la compression et traction iy=iz
Ncsd=min(d1)*-1;Ntsd=max(d2);R11=R1(2);R21=R2(2)*-1;
[lambda,lambdabar,alpha,phi,Xi,Nbrd,Ntrd]=flam1(Ld,'corner',Tdiag,'double fixed',Ncsd,Ntsd);
var2={'lambda','lambdabar','alpha','phi','Xi','Nbrd','Ntrd','Ncsd','Ntsd','R1','R2'};
T13=table(lambda,lambdabar,alpha,phi,Xi,Nbrd,Ntrd,Ncsd,Ntsd,R11,R21,'VariableNames',var2);
end
%% end
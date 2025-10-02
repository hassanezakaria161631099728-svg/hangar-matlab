function [T1,T2,Thea,Tcor,T3,T4,T5]=bracedframe(beamT,chIII_1,hangarf)
ba=readtable(hangarf,'sheet','building attributes');
in=readtable(chIII_1,'sheet','T4');
in2=readtable(beamT,'sheet','HEA');
in3=readtable(chIII_1,'sheet','T13');
in4=readtable(beamT,'sheet','corniere');
h=ba{1,1};Ly=ba{1,4};
[T1,q,df1,df2]=chaeqimp(in,h-2,'poteau');
T2=table(q,df1,df2);
t=Ly/4;
%dimensionnement de la panne sabliere
izmin=t/300;%axe flambemant plus fort z dans la sabliere
Thea=beam4(izmin,16,in2);%panne sabliere en HEA
%dimensionnement des diagonales
L=((h-2)^2+(t/2)^2)^0.5;%m longeur de la diagonale
iymin=L/3;
Tcor=beam4(iymin,12,in4);%diagonale corniere
Theb=readtable(chIII_1,'sheet','T4');
%truss building V shape
nodes=[0,0;t,0;                   %below
       0,(h-2);t/2,(h-2);t,(h-2)];%above
elements=[3,4;4,5%above
          1,3;2,5%vertical           
          1,4;4,2];%diagonal
R1=in3{1,10};R2=in3{1,11};
loads1=[1,-1*df2;5,-1*(df1+R1)];
loads2=[1,df2;5,R2+df2];
constraints=[1,2,3,4];
A_h=Thea{1,9}*1e-4;      % m² horizontal panne sabliere HEA
A_v=Theb{1,9}*1e-4;      % m² vertical poteau HEB
A_d=Tcor{1,9}*1e-4;    % m² diagonal corniere
[~,~,FV1]=FEM2D4(A_h,A_v,A_d,nodes,elements,loads1,constraints);
[~,~,FV2]=FEM2D4(A_h,A_v,A_d,nodes,elements,loads2,constraints);
c={'s1';'s2';'poteau';'potelet';'d1';'d2'};
var={'element','vent1','vent2'};
T3=table(c,FV1,FV2,'VariableNames',var);
Ncsdps=FV2(1)*-1;Ncsdd=FV2(5);
%verification de la panne sabliere
[laz,lazb,alphaz,phiz,Xiz,Nbrdz]=flam1(t,'z',Thea,'double fixed',Ncsdps,1);
%verification des diagonales
[lay,layb,alphay,phiy,Xiy,Nbrdy]=flam1(L,'corner',Tcor,'double fixed',Ncsdd,1);
T4=table(t,laz,lazb,alphaz,phiz,Xiz,Nbrdz,Ncsdps);
T5=table(L,lay,layb,alphay,phiy,Xiy,Nbrdy,Ncsdd);
end
%% end
    
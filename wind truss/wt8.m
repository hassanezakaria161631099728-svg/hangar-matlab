function [T8,T9,T10,p1,d1,d2,R1,R2]=wt8(Fwi1,Fwi2,hi,dF1,dF2,qw1,qw2,Lx,Ly,Ttrav,Tpot,Tdiag)
F1=zeros(1,5);F2=zeros(1,5);
for i=1:5
dF=[dF2,dF1,dF1,dF1,dF2];
F1(i)=1.5*Fwi1(i)-dF(i);
F2(i)=1.5*Fwi2(i)+dF(i);
end
c={'hi';'qw1';'qw2';'Fwi1';'Fwi2';'dF';'F1';'F2'};
var={'attributes','M1','M2','M3','M4','M5'};
M=[hi;qw1;qw2;Fwi1;Fwi2;dF;F1;F2];
T8=table(c,M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),'VariableNames',var);
%truss building
l=Lx/4;t=Ly/4;
nodes=[0,0;l,0;2*l,0;3*l,0;4*l,0
       0,t;l,t;2*l,t;3*l,t;4*l,t];
elements=[1,2;2,3;3,4;4,5;%below
          6,7;7,8;8,9;9,10%above
          1,6;2,7;3,8;4,9;5,10%vertical           
          1,7;2,6;2,8;3,7;3,9;4,8;4,10;5,9];%diagonal
loads1=[2,F1(1);4,F1(2);6,F1(3);8,F1(4);10,F1(5)];
loads2=[2,F2(1);4,F2(2);6,F2(3);8,F2(4);10,F2(5)];
constraints=[1,2,9,10];
A_h=Ttrav{1,9}*1e-4;      % m² horizontal
A_v=Tpot{1,9}*1e-4;      % m² vertical
A_d=Tdiag{1,9}*1e-4;    % m² diagonal
[u1,R1,FV1]=FEM2D4(A_h,A_v,A_d,nodes,elements,loads1,constraints);
[u2,R2,FV2]=FEM2D4(A_h,A_v,A_d,nodes,elements,loads2,constraints);
%tableaux des forces axiales
var1={'panne','V1','V2'};
c={'P1';'P2';'P3';'P4';'P5'};
p1=FV1(9:13);p2=FV2(9:13);
T9=table(c,p1,p2,'VariableNames',var1);
var2={'panne','V1','V2'};
c2={'D1';'D2';'D3';'D4';'D5';'D6';'D7';'D8'};
d1=FV1(14:21);d2=FV2(14:21);
T10=table(c2,d1,d2,'VariableNames',var2);
end

%% end
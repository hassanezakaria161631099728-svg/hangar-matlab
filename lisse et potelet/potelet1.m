function [qw1,s1,s2,bpa,ha]=potelet1(b,Lx,Ly,e,qpze,wi,hp)
%les potelets
epfD=0.8;
weD=epfD*qpze;
bp=Lx/4;k=Lx/2;%largeur de potelet
h1=(2/k)*0.5*bp+hp;h2=(2/k)*1.5*bp+hp;
if b==Ly 
ba=e/5;
if ba<1.5*bp
bpa=ba-0.5*bp;bpb=bp-bpa;
ha=(2/k)*ba+hp;
sa=(h1+ha)*(bpa/2);
sb=(ha+h2)*(bpb/2);
else
bpa=bp;bpb=0;sa=(h1+h2)*(bp/2);sb=0;    
end
epfA=depf2(-1.3,-1,sa);epfB=depf2(-1,-0.8,sb);
weA=epfA*qpze;weB=epfB*qpze;
qwA=(weA-wi)*bpa;qwB=(weB-wi)*bpb;
qw=qwA+qwB;
disp('potelet 1 est plus sollicite pour V1 qw<0')
s1=sa;s2=sb;
elseif b==Lx %b surface perpendiculaire au vent 
sd=(h2+0.25)*bp;
qw=(weD-wi)*bp;%bp largeur efficase du potelet
s1=sd;
disp('potelet 2 est plus sollicite pour V2 qw>0')
end
qw1=qw/10;%daN/ml
end
%% end
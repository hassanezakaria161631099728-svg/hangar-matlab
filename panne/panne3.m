function [acp,combdel,combV,combM,...
delmax,del2,Vysdn,Vzsdp,Mysdn,Mzscorr,Mysdp,Mzsdp]=panne3(T1,...
qgy,qgz,qw,Qy,Qz,qwp,qsy,qsz,Ly)
%actions of the beam
Iy=T1{1,10};%cm^4
[Mgy,Vgy,delgy,Mw,Vw,delw,MQy,VQy,delQy,Mgz,Vgz,MQz,VQz,Mwp,Vwp,...
delwp,Msy,Vsy,delsy,Msz,Vsz]=panne31(qgy,qgz,qw,Qy,Qz,qwp,qsy,qsz,Iy,Ly);
%bending is only on y axis of the beam
acp=panne32(Mgy,Vgy,delgy,Mw,Vw,delw,MQy,VQy,delQy,Mgz,...
Vgz,MQz,VQz,Mwp,Vwp,delwp,Msy,Vsy,delsy,Msz,Vsz,qgy,...
qgz,qw,Qy,Qz,qwp,qsy,qsz);
%combination of actions 
%ELS
[combdel,delmax,del2]=panne33(delgy,delw,delQy,delwp,delsy);
%ELU
%shear forces
[combV,Vysdn,~,~,Vzsdp]=panne34(Vgy,Vgz,Vw,VQy,Vsy,Vwp,VQz,Vsz);
%momentum
[combM,Mysdn,Mzscorr,Mysdp,Mzsdp]=panne34(Mgy,Mgz,Mw,MQy,Msy,Mwp,MQz,Msz);
end
%% end
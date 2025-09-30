function [Mgy,Vgy,delgy,Mw,Vw,delw,MQy,VQy,delQy,Mgz,Vgz,MQz,VQz,Mwp,Vwp,...
delwp,Msy,Vsy,delsy,Msz,Vsz]=panne31(qgy,qgz,qw,Qy,Qz,qwp,qsy,qsz,Iy,Ly)
t=Ly/4;L=t;
lt1='uniform';lt2='double ponctuel';%load type
[Mgy,Vgy,delgy]=MV(lt1,'y',qgy*10^-5,L,Iy*10^-8);
[Mw,Vw,delw]=MV(lt1,'y',qw*10^-5,L,Iy*10^-8);
[MQy,VQy,delQy]=MV(lt2,'y',Qy*10^-5,L,Iy*10^-8);
[Mgz,Vgz,~]=MV(lt1,'z',qgz*10^-5,L,Iy);
[MQz,VQz,~]=MV(lt2,'z',Qz*10^-5,L,Iy);
[Mwp,Vwp,delwp]=MV(lt1,'y',qwp*10^-5,L,Iy*10^-8);
[Msy,Vsy,delsy]=MV(lt1,'y',qsy*10^-5,L,Iy*10^-8);
[Msz,Vsz,~]=MV(lt1,'y',qsz*10^-5,L,Iy);
end
%% end
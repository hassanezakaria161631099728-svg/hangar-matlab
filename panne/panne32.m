function acp=panne32(Mgy,Vgy,delgy,Mw,Vw,delw,MQy,VQy,delQy,Mgz,...
Vgz,MQz,VQz,Mwp,Vwp,delwp,Msy,Vsy,delsy,Msz,Vsz,qgy,...
qgz,qw,Qy,Qz,qwp,qsy,qsz)
c={'y';'y';'y';'z';'z'};
ci={'G';'W-';'Q';'G';'Q'};
loadi=[qgy;qw;Qy;qgz;Qz];
Mi=[Mgy;Mw;MQy;Mgz;MQz]*10^5;
Vi=[Vgy;Vw;VQy;Vgz;VQz]*10^5;
deli=[delgy;delw;delQy;0;0]*100;
cj={'G';'W+';'S';'G';'S'};
loadj=[qgy;qwp;qsy;qgz;qsz];
Mj=[Mgy;Mwp;Msy;Mgz;Msz]*10^5;
Vj=[Vgy;Vwp;Vsy;Vgz;Vsz]*10^5;
delj=[delgy;delwp;delsy;0;0]*100;
t1={'i';'i';'i';'i';'i'};
t2={'j';'j';'j';'j';'j'};
var={'panne','axis','comb','load','M','V','del'};
acp=table([t1;t2],[c;c],[ci;cj],[loadi;loadj],[Mi;Mj],[Vi;Vj],...
[deli;delj],'VariableNames',var);
end
%% end
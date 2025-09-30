function T=lierne(t,qgp,qgc,s2,alpha,L)
np=7;
d=1.41;%m
B=(L/2)/cosd(alpha)-0.6-d/2;
G=(np-1)*qgp+qgc*B;Q1=s2*B;
qsdt=comb(G,Q1,0,'ELU',1,'snow');
NT=1.25*qsdt*sind(alpha)*t/2;
beta=atand(d/(t/2));
Nsd=NT/(2*sind(beta));
T=table(np,B,qsdt,NT,beta,Nsd);
end

%% end
function [G,qsdt,L,NT,Nsd,beta]=lierlis(hp,qgl,qgb,lf,t,cas)
nl=hp-1;
if strcmp(cas,'side')   
n=nl-1;k=-1;L=t;
elseif strcmp(cas,'front')
n=nl;k=1;L=lf;
end
G=(n*qgl+qgb*(hp-2+k*0.5));
qsdt=1.35*G;
NT=1.25*qsdt*L/2;
if strcmp(cas,'side')   
beta=atand(1/(t/2));
Nsd=NT/(2*sind(beta));
elseif strcmp(cas,'front')
Nsd=NT;
end

end
%% end
function [T,qw]=wt3(si,sf,sI,sII,sIII,di,df,dI,dII,dIII,chI)
%wind1 case
[sa,sb,sc]=wt31(si,sf,sI,sII,sIII);
[ba,bb,bc]=wt31(di,df,dI,dII,dIII);
[epfa,epfb,epfc,qwa,qwb,qwc,qw]=wt32(sa,sb,sc,ba,bb,bc,chI);
c={'si';'sf';'di';'df';'sa';'sb';'sc';'ba';'bb';'bc';'epfa';'epfb';'epfc';
'qwa';'qwb';'qwc';'qw'};
var={'attributes','M1','M2','M3','M4','M5'};
M=[si;sf;di;df;sa;sb;sc;ba;bb;bc;epfa;epfb;epfc;qwa;qwb;qwc;qw];
T=table(c,M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),'VariableNames',var);
end
%% end
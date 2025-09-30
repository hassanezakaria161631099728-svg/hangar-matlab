function qw=panne1(ba,bt,b,Troof,table1,table2,table3,bp)
% pannes de toiture ba,b,T,L,e,d,Troof
L=ba{1,3};T=ba{1,4};t=T/4;%m
e=table1{1,4};qpze=table2{1,3};ipf=table3{1,3};
if strcmp(bt,'gable')
if b==T % wind 1 direction teta=0
bpf=bp;bpg=bpf;bph=0;
bf=e/4;
if t<=bf
tf=t;tg=0;th=t;
elseif t>bf
tf=bf;tg=t-bf;th=t;
end
elseif b==L % wind 2 direction teta=90
df=e/10;tf=df;th=t-df;tg=df;
bpf=bp;bpg=0;bph=bp;
end
sf=bpf*tf;sg=bpf*tg;sh=bph*th;
[epff]=depf2(Troof{1,2},Troof{2,2},sf);
[epfg]=depf2(Troof{1,3},Troof{2,3},sg);
[epfh]=depf2(Troof{1,4},Troof{2,4},sh);
qwf=qpze*(epff-ipf)*bpf;
qwg=qpze*(epfg-ipf)*bpg;
qwh=qpze*(epfh-ipf)*bph;
if b==T % wind 1 direction teta=0
qw1=qwf;t1=tf;qw2=qwg;t2=tg;
epfJp=Troof{3,6};
qwJp=qpze*(epfJp-ipf)*bp;
elseif b==L % wind 2 direction teta=90
qw1=qwf;t1=tf;qw2=qwh;t2=th;
end
end
qweq=(qw1*t1+qw2*t2)/t;
if b==T % wind 1 direction teta=0
qw=[qweq;qwJp];
elseif b==L % wind 2 direction teta=90
qw=qweq;
end
end
%% end
function [epfa,epfb,epfc,qwa,qwb,qwc,qw]=wt32(sa,sb,sc,ba,bb,bc,chI)
%wind truss
in=readtable(chI,'sheet','T2');
in2=readtable(chI,'sheet','T3');
qpze1=in{1,3};wi1=in2{1,5};
%front of hangar zones intersections
epf1a=[-1.3,-1.3,-1.3,-1.3,-1.3];epf10a=[-1,-1,-1,-1,-1];
epf1b=[-1,-1,-1,-1,-1];epf10b=[-0.8,-0.8,-0.8,-0.8,-0.8];
epf1c=[-0.5,-0.5,-0.5,-0.5,-0.5];
qpze=[qpze1,qpze1,qpze1,qpze1,qpze1];wi=[wi1,wi1,wi1,wi1,wi1];
epfa=zeros(1,5);epfb=zeros(1,5);epfc=zeros(1,5);
wea=zeros(1,5);web=zeros(1,5);wec=zeros(1,5);
qwa=zeros(1,5);qwb=zeros(1,5);qwc=zeros(1,5);qw=zeros(1,5);
for i=1:5
epfa(i)=depf2(epf1a(i),epf10a(i),sa(i));wea(i)=qpze(i)*epfa(i);qwa(i)=(wea(i)-wi(i))*ba(i);
epfb(i)=depf2(epf1b(i),epf10b(i),sb(i));web(i)=qpze(i)*epfb(i);qwb(i)=(web(i)-wi(i))*bb(i);
epfc(i)=depf2(epf1c(i),epf1c(i),sc(i));wec(i)=qpze(i)*epfc(i);qwc(i)=(wec(i)-wi(i))*bc(i);
qw(i)=(qwa(i)+qwb(i)+qwc(i))/10;
end

end
%% end
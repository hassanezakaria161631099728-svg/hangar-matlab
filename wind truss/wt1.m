function [di,df,dI,dII,dIII,h1,h2,s1,s2,s3]=wt1(ba,e)
%wind truss
Lx=ba{1,3};h3=ba{1,1};h0=h3-2;a=ba{1,5};%angle alpha
lf=Lx/4;%lenght of front wall beam
d1=lf/2;h1=h0+d1*sind(a);
d2=d1+lf;h2=h0+d2*sind(a);
d3=d2+lf;
d4=d3+lf;
d5=d4+lf/2;
di=[0,d1,d2,d3,d4];
df=[d1,d2,d3,d4,d5];
dI=e/5;dII=e;dIII=Lx;
s1=(h0+h1)*lf/4;s2=(h1+h2)*lf/2;s3=h2*lf+(h3-h2)*lf/2;
end
%% end
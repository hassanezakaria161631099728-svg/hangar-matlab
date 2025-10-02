function [si,sf,ha,hb,sI,sII,sIII]=wt2(sin1,sin2,sin3,dI,dII,ba)
%wind truss
h0=ba{1,2};a=ba{1,5};Lx=ba{1,3};h2=ba{1,1};
s1=sin1;s2=s1+sin2;s3=s2+sin3;s4=s3+sin2;s5=s4+sin1;
si=[0,s1,s2,s3,s4];
sf=[s1,s2,s3,s4,s5];
ha=h0+dI*sind(a);
hb=h0+(Lx-dII)*sind(a);
sI=(h0+ha)*dI/2;
sII=sI+(ha+h2)*(Lx/2-dI)/2+(h2+hb)*(dII-Lx/2)/2;
sIII=sII+(hb+h0)*(Lx-dII)/2;
end
%% end
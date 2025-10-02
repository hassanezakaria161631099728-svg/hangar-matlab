function [a,b,c,s]=wt31(si,f,I,II,III)
%wind truss
%front of hangar zones intersections
a=zeros(1,5);b=zeros(1,5);c=zeros(1,5);
for i=1:5
if f(i)<I
a(i)=f(i);b(i)=0;c(i)=0;
elseif si(i)<I && f(i)>I
a(i)=I-si(i);b(i)=f(i)-I;c(i)=0;
elseif si(i)>I && f(i)<II
a(i)=0;b(i)=f(i)-si(i);c(i)=0;
elseif si(i)<II && f(i)>II
a(i)=0;b(i)=II-si(i);c(i)=f(i)-II;
elseif si(i)>II && f(i)<=III
a(i)=0;b(i)=0;c(i)=f(i)-si(i);
end
end
s=sum(a)+sum(b)+sum(c);
end
%% end
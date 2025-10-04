function nodes=crenod(location,d,np,l,he)
N=np+1;%number of particles of the truss + 1
%l distance between two sets of the nodes  
x=zeros(2*N,1);y=zeros(2*N,1);
if strcmp(location,'roof')
x(1:N)=d;x(N+1:2*N)=d;
for i=1:N
y(i)=0;
end
for i=N+1:2*N
y(i)=l;
end
elseif strcmp(location,'wall')
h=zeros(N,1);
for i=2:N
h(i)=(i-1)*he;x(i)=0;
end
for i=N+1:2*N
x(i)=l;
end
y(1:N)=h;y(N+1:2*N)=h;
end
nodes=[x,y];
end
%% end
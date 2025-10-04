function plotruss(nodes,elements,axial_forces)
% --- Plotting ---
figure; hold on; axis equal; grid on;
xlabel('X (m)'); ylabel('Y (m)');
Pcount=0; Dcount=0;
n_elems = size(elements,1);
for e=1:n_elems
    n1 = elements(e,1); n2 = elements(e,2);
    x=[nodes(n1,1),nodes(n2,1)];
    y=[nodes(n1,2),nodes(n2,2)];
    xm=mean(x); ym=mean(y);    
    % Orientation check
    if abs(y(1)-y(2))<1e-6
        color='g'; % Horizontal
        plot(x,y,'-','LineWidth',2,'Color',color);        
    elseif abs(x(1)-x(2))<1e-6
        color='y'; % Vertical
        plot(x,y,'-','LineWidth',2,'Color',color);
        Pcount=Pcount+1;
        text(xm,ym,sprintf('FV%d=%.2f',Pcount,axial_forces(e)),...
            'FontSize',9,'Color','k','FontWeight','bold');        
    else
        color='b'; % Diagonal
        plot(x,y,'-','LineWidth',2,'Color',color);
        Dcount=Dcount+1;
        text(xm,ym,sprintf('FD%d=%.2f',Dcount,axial_forces(e)),...
            'FontSize',9,'Color','k','FontWeight','bold');
    end
end
% Nodes
for i=1:size(nodes,1)
    plot(nodes(i,1),nodes(i,2),'ro','MarkerSize',8,'MarkerFaceColor','r');
    text(nodes(i,1)+0.1,nodes(i,2),['N' num2str(i)],'FontSize',10);
end
end


%% end

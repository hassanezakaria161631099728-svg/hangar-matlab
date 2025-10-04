function plonod(nodes)
% Plot truss with color-coded element types and labels
figure;
hold on;
axis equal;
grid on;
xlabel('X (m)');
ylabel('Y (m)');
% --- Plot nodes ---
for i = 1:size(nodes,1)
    plot(nodes(i,1), nodes(i,2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    text(nodes(i,1)+0.1, nodes(i,2), ['N' num2str(i)], 'FontSize',10);
end
end
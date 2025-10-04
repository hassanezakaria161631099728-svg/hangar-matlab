function plotruss2(nodes,elements)
% Plot truss with color-coded element types and labels
figure;
hold on;
axis equal;
grid on;
xlabel('X (m)');
ylabel('Y (m)');
% Counters for labeling
Pcount = 0;
Dcount = 0;
% --- Plot elements ---
for i = 1:size(elements,1)
    n1 = elements(i,1);
    n2 = elements(i,2);
    x = [nodes(n1,1), nodes(n2,1)];
    y = [nodes(n1,2), nodes(n2,2)];
    % Midpoint of element for label placement
    xm = mean(x);
    ym = mean(y);
    % Check orientation
    if abs(y(1)-y(2)) < 1e-6      % Horizontal
        color = 'g';
        plot(x, y, '-', 'LineWidth', 2, 'Color', color);
    elseif abs(x(1)-x(2)) < 1e-6  % Vertical
        color = 'y';
        plot(x, y, '-', 'LineWidth', 2, 'Color', color);
        Pcount = Pcount + 1;
        text(xm, ym, ['P' num2str(Pcount)], ...
             'FontSize', 10, 'Color', 'k', 'FontWeight', 'bold');
    else                          % Diagonal
        color = 'b';
        plot(x, y, '-', 'LineWidth', 2, 'Color', color);
        Dcount = Dcount + 1;
        text(xm, ym, ['D' num2str(Dcount)], ...
             'FontSize', 10, 'Color', 'k', 'FontWeight', 'bold');
    end
end
% --- Plot nodes ---
for i = 1:size(nodes,1)
    plot(nodes(i,1), nodes(i,2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
    text(nodes(i,1)+0.1, nodes(i,2), ['N' num2str(i)], 'FontSize',10);
end
end

%% end
    
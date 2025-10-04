function plostr(nodes,elements)
    % PLOTSTRUCTURE Plots nodes and elements of a 2D structure
    %
    % Inputs:
    % nodes - Nx2 matrix of node coordinates [x y]
    % elements - Mx2 matrix of element connectivity [startNode endNode]
    figure;
    hold on;
    axis equal;
    grid on;
    xlabel('X');
    ylabel('Y');
    title('2D Structure Plot');
    % Plot elements
    for i = 1:size(elements,1)
        n1 = elements(i,1);
        n2 = elements(i,2);
        x = [nodes(n1,1), nodes(n2,1)];
        y = [nodes(n1,2), nodes(n2,2)];
        plot(x, y, 'b-', 'LineWidth', 2);
        % Optional: label the element
        midX = mean(x);
        midY = mean(y);
        text(midX, midY, ['E' num2str(i)], 'FontSize', 8, 'Color', 'b');
    end
    % Plot nodes
    for i = 1:size(nodes,1)
        plot(nodes(i,1), nodes(i,2), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
        text(nodes(i,1)+0.1, nodes(i,2)+0.1, ['N' num2str(i)], 'FontSize', 9, 'Color', 'k');
    end
    hold off;
end
%% end
    
function elements=crelem(nodes)
% CRELEM_X  Generate element connectivity for an X-braced two-column wall/truss
%   elements = crelem_X(nodes)
% INPUT
%   nodes    : (2N x 2) array of node coordinates [x y]
%              assumed layout: indices 1..N = left column, N+1..2N = right column
% OUTPUT
%   elements : K x 2 array of connectivity [node_i node_j] (1-based indices)
% Notes:
%  - Creates verticals (left & right), horizontals (left-right per row),
%    and X-diagonals across each panel between adjacent rows.
nNodes = size(nodes,1);
if mod(nNodes,2) ~= 0
    error('crelem_X: nodes must contain an even number of rows (two columns of equal length).');
end
N = nNodes/2;  % number of rows per column
el = []; % element list accumulator
% 1) Vertical elements (left column)
for i = 1:(N-1)
    el(end+1,:) = [i, i+1];          % left i -> left i+1
end
% 2) Vertical elements (right column)
for i = 1:(N-1)
    el(end+1,:) = [N+i, N+i+1];      % right i -> right i+1
end
% 3) Horizontal elements (chords) between left and right at each row
for i = 2:N
    el(end+1,:) = [i, N+i];          % left i <-> right i
end
% 4) X-diagonals for each panel between row i and i+1
%    - diagonal A: left i -> right i+1
%    - diagonal B: right i -> left i+1
for i = 1:(N-1)
    el(end+1,:) = [i, N + (i+1)];    % left i -> right i+1
    el(end+1,:) = [N + i, i+1];      % right i -> left i+1
end
% Return as integer matrix
elements = int32(el);
end
%% end
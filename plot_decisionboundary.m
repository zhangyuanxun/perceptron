%% Plot decision boundary
function [line] = plot_decisionboundary(X, weights, style)
%%
% Plots the decision bounday based on the data points X
% Inputs:
%   X - data points
%   weights - weights of decision bounday for these points
%%

% need 2 points to define a line, so choose two endpoints
plot_x = [min(X(:,1))-1,  max(X(:,1))+1];

% Calculate the decision boundary line
plot_y = (-1./weights(2)).*(weights(1).*plot_x + weights(3));

% Plot, and adjust axes for better viewing
line = plot(plot_x, plot_y, style);
set(line, 'LineWidth', 1.5);
end
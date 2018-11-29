%% Plots information about a perceptron classifier on a 2-dimensional dataset.
function plot_perceptron(neg_examples, pos_examples, w_gen_feas, weights, iter)
%%
% Geometric view of weights changing
% Inputs:
%   neg_examples - The num_neg_examples x 3 matrix for the examples with target 0.
%       num_neg_examples is the number of examples for the negative class.
%   pos_examples- The num_pos_examples x 3 matrix for the examples with target 1.
%       num_pos_examples is the number of examples for the positive class.

%%
f = figure(1);
clf(f);
axis auto;

hold on;
if (~isempty(neg_examples))
	plot(neg_examples(:,1),neg_examples(:,2),'ob','markersize',12,'LineWidth', 1.5);
end
if (~isempty(pos_examples))
	plot(pos_examples(:,1),pos_examples(:,2),'sr','markersize',12,'LineWidth', 1.5);
end

% plot decision boundary
all_samples = [neg_examples(:); pos_examples(:)];
if (~isempty(w_gen_feas))
    fesi_boundary = plot_decisionboundary(all_samples, w_gen_feas, '-k');
end

learn_boundary = plot_decisionboundary(all_samples, weights, '--m');

% plot weight vector arrow, start from middle point of boundary line
% normalize the weights
v = [weights(1); weights(2)];
v = v / norm(v);
arrow = quiver(0, 0, v(1), v(2));
set(arrow, 'LineWidth', 1.5, 'color', 'red');
if (~exist('fesi_boundary','var'))
    lg = legend([arrow, learn_boundary],{'Weight vector', 'Learned boundary'}, 'location', 'Northwest');
else
    lg = legend([arrow, fesi_boundary, learn_boundary],{'Weight vector', 'Feasible boundary', 'Learned boundary'}, 'location', 'Northwest');
end

t = ['Num of iteration = ', num2str(iter)];
title(t);
set(lg, 'FontSize', 10);
xlim([-2,2]);
ylim([-2,2]);
daspect([1 1 1])
set(gca,'Box','on');
hold off;
drawnow;

% Write GIF
frame = getframe(f); 
im = frame2im(frame); 
[imind,cm] = rgb2ind(im,256); 
if iter == 0
    imwrite(imind,cm,'demo/demo2.gif', 'gif', 'Loopcount',inf); 
else 
    imwrite(imind,cm,'demo/demo2.gif', 'gif', 'WriteMode','append'); 
end 

end
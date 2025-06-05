% plotting code
% run foil first then uses data from foil to plot

folder = ['.\figures\',caseref,'\']; 
mkdir(folder)
% 
% figure('Position', [0, 0, 800, 200]); hold on
% plot(xs,ys)
% [xk yk] = textread ( 'Geometry/naca0012_5.surf', '%f%f' );
% plot(xk,yk,'--r')
% axis image
% xlabel('$x$', 'Interpreter', 'latex')
% ylabel('$y$', 'Interpreter', 'latex')
% ax = gca;
% ax.TickLabelInterpreter = 'latex'; 
% set(gca, 'FontSize', 14) 
% box on
% yticks([-0.04 0 0.04])
% 
% print([folder, 'airfoil.eps'], '-depsc')
% print([folder, 'airfoil.png'], '-dpng', '-r300')

its = ilts+iuts;

zero_inds = its == 0;
d = diff([0, zero_inds, 0]); 
start_idx = find(d == 1);  
end_idx = find(d == -1) - 1;

lengths = end_idx - start_idx + 1;

[~, max_idx] = max(lengths);

start_idx = start_idx(max_idx);
end_idx = end_idx(max_idx);

if isempty(start_idx)
    start_idx = 1;
    end_idx = length(its);
end

[max_val, idx] = max(lovdswp(start_idx:end_idx));

idx = start_idx-1+idx;

figure; hold on
plot(alpha, lovdswp)
yl = ylim; 
xl = xlim;
if start_idx > 1
    fill([xl(1), alpha(start_idx-1), alpha(start_idx-1), xl(1)], ...
         [yl(1), yl(1), yl(2), yl(2)], ...
         [0.7 0.7 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
end

% Shade the right region after the zero section
if end_idx < length(alpha)
    fill([alpha(end_idx+1), xl(2), xl(2), alpha(end_idx+1)], ...
         [yl(1), yl(1), yl(2), yl(2)], ...
         [0.7 0.7 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
end
xlabel('$\alpha$', 'Interpreter', 'latex')
ylabel('$C_L/C_D$', 'Interpreter', 'latex')
str = ['max $C_L/C_d$ = ', num2str(lovdswp(idx), '%.1f'),', at $\alpha = ' num2str(alpha(idx), '%.1f') '^\circ$'];
text(0.35, 0.1, str, 'Units', 'normalized', ...
     'Interpreter', 'latex', 'FontSize', 14, ...
     'VerticalAlignment', 'top')
ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 14) 
box on
xlim(xl)
ylim(yl)
print([folder, 'alpha_clcd.eps'], '-depsc')
print([folder, 'alpha_clcd.png'], '-dpng', '-r300')

figure; hold on
plot(clswp,cdswp)
yl = ylim; 
xl = xlim;
if start_idx > 1
    fill([xl(1), clswp(start_idx-1), clswp(start_idx-1), xl(1)], ...
         [yl(1), yl(1), yl(2), yl(2)], ...
         [0.7 0.7 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
end

% Shade the right region after the zero section
if end_idx < length(alpha)
    fill([clswp(end_idx+1), xl(2), xl(2), clswp(end_idx+1)], ...
         [yl(1), yl(1), yl(2), yl(2)], ...
         [0.7 0.7 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
end
xlabel('$C_L$', 'Interpreter', 'latex')
ylabel('$C_D$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 14) 
box on
xlim(xl)
ylim(yl)
print([folder, 'cl_cd.eps'], '-depsc')
print([folder, 'cl_cd.png'], '-dpng', '-r300')



figure; hold on
plot(alpha, clswp)
yl = ylim; 
xl = xlim;
if start_idx > 1
    fill([xl(1), alpha(start_idx-1), alpha(start_idx-1), xl(1)], ...
         [yl(1), yl(1), yl(2), yl(2)], ...
         [0.7 0.7 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
end

% Shade the right region after the zero section
if end_idx < length(alpha)
    fill([alpha(end_idx+1), xl(2), xl(2), alpha(end_idx+1)], ...
         [yl(1), yl(1), yl(2), yl(2)], ...
         [0.7 0.7 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.3)
end
xlabel('$\alpha$', 'Interpreter', 'latex')
ylabel('$C_L$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 14) 
box on
xlim(xl)
ylim(yl)
print([folder, 'alpha_cl.eps'], '-depsc')
print([folder, 'alpha_cl.png'], '-dpng', '-r300')



fname = ['Data/' caseref '_' num2str(alpha(idx)) '.mat'];
load( fname, 'Cl', 'Cd', 'xs', 'cp')

figure('Position', [0, 0, 800, 500]); 
subplot(2,1,1);hold on
plot(xs,ys)
[xk yk] = textread ( 'Geometry/naca0009_5.surf', '%f%f' );
plot(xk,yk,'--r')

axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 14) 
box on
yticks([-0.04 0 0.04])

subplot(2,1,2); hold on
plot(xs,-cp)
yline(0,'--k')
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$-C_p$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 14) 
box on
str = ['$\alpha = ' num2str(alpha(idx), '%.1f') '^\circ$'];
text(0.8, 0.95, str, 'Units', 'normalized', ...
     'Interpreter', 'latex', 'FontSize', 14, ...
     'VerticalAlignment', 'top')
print([folder, 'cp.eps'], '-depsc')
print([folder, 'cp.png'], '-dpng', '-r300')
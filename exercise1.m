% clear 
% close all
% 
% addpath('./functions')

xmin = -2.5;
xmax = 2.5;
nx = 51;
ymin = -2;
ymax = 2;
ny = 41;
xc = 0.75;
yc = 0.5;
Gamma = 3;

x = linspace(xmin,xmax,nx);
y = linspace(ymin,ymax,ny);

[ym, xm] = meshgrid(y, x);


psi = psipv(xc,yc,Gamma,xm,ym);

c = -0.4:0.2:1.2;

figure
contour(xm,ym,psi,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 16)

% plot contours
c = -1.75:0.25:1.75;
figure
contour(xm, ym ,psi ,c)



xmin = -2.5;
xmax = 2.5;
nx = 51;
ymin = -2;
ymax = 2;
ny = 41;

x = linspace(xmin,xmax,nx);
y = linspace(ymin,ymax,ny);

[ym, xm] = meshgrid(y, x);


del = 1.5;

[infa, infb] = refpaninf(del,xm,ym);

c = -0.15:0.05:0.15;

figure
contour(xm,ym,infa,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)

figure
contour(xm,ym,infb,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)

% Discretised estimate for infa
nv = 100;

xpos = del/nv/2:del/nv:(del-del/nv/2);
gammaA = (1-1/del*xpos)*del/nv;
gammaB = (1/del*xpos)*del/nv;

infaEst = zeros(size(xm));
infbEst = infaEst;

for i = 1:length(xpos)
    infaEst = infaEst+psipv(xpos(i),0,gammaA(i),xm,ym);
    infbEst = infbEst+psipv(xpos(i),0,gammaB(i),xm,ym);
end

figure
contour(xm,ym,infaEst,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)

figure
contour(xm,ym,infbEst,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)

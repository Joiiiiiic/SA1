
xa = 4.1; ya = 1.3; xb = 2.2; yb = 2.9;
del = norm([xb-xa,yb-ya]);

x = linspace(0,5,50);
y = linspace(0,4,40);

[ym2, xm2] = meshgrid(y, x);

[infa, infb] = panelinf(xa,ya,xb,yb,xm2,ym2);

c = -0.15:0.05:0.15;

figure
contour(xm2,ym2,infa,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)

figure
contour(xm2,ym2,infb,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)

% Discretised estimate for infa
nv = 100;

xpos = linspace(xa,xb,nv+1);
xpos = 0.5*(xpos(1:end-1)+xpos(2:end));
ypos = linspace(ya,yb,nv+1);
ypos = 0.5*(ypos(1:end-1)+ypos(2:end));

gammaA = linspace(1-1/(2*nv),1/(2*nv),nv)*del/nv;
gammaB = linspace(1/(2*nv),1-1/(2*nv),nv)*del/nv;

infaEst = zeros(size(xm2));
infbEst = infaEst;

for i = 1:nv
    infaEst = infaEst+psipv(xpos(i),ypos(i),gammaA(i),xm2,ym2);
    infbEst = infbEst+psipv(xpos(i),ypos(i),gammaB(i),xm2,ym2);
end

figure
contour(xm2,ym2,infaEst,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)

figure
contour(xm2,ym2,infbEst,c)
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)

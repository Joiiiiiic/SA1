xmin = -2.5;
xmax = 2.5;
nx = 51;
ymin = -2;
ymax = 2;
ny = 41;

x = linspace(xmin,xmax,nx);
y = linspace(ymin,ymax,ny);

[ym, xm] = meshgrid(y, x);


np = 100;
theta = (0:np)*2*pi/np;
xs = cos(theta);
ys = sin(theta);
gamma = -2*sin(theta);

psi = ym;

% nested loop to add each panel's contributions to streamfunction
for k = 1:np
    [infa, infb] = panelinf(xs(k), ys(k), xs(k+1), ys(k +1), xm, ym);
    gammaa = gamma(k);
    gammab = gamma(k+1);
    psi = psi+(gammaa*infa)+(gammab*infb);
end

% plot contours
c = -1.75:0.25:1.75;
figure; hold on;
contour(xm, ym ,psi ,c)
plot(xs,ys);
axis image
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 14)
hold off
box on
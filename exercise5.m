clear
close all

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

alpha = 0;
A = build_lhs(xs,ys);
b = build_rhs(xs,ys,alpha);
gam = A\b;

disp(['total circulation: ', num2str(sum(gam)*(theta(2)-theta(1)))])

figure
plot(theta/pi,gam)
axis([0 2 -2.5 2.5])

xlabel('$\theta / \pi$', 'Interpreter', 'latex')
ylabel('$u_\theta$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)
box on

% plot streamline graph to check
psi = ym*cos(alpha) -xm*sin(alpha);

for k = 1:np
    [infa, infb] = panelinf(xs(k), ys(k), xs(k+1), ys(k +1), xm, ym);
    psi = psi+(gam(k)*infa)+(gam(k+1)*infb);
end

c = -1.75:0.25:1.75;

figure; hold on;
contour(xm, ym ,psi ,c)
plot(xs,ys);
xlabel('$x$', 'Interpreter', 'latex')
ylabel('$y$', 'Interpreter', 'latex')
ax = gca;
ax.TickLabelInterpreter = 'latex';
set(gca, 'FontSize', 18)
hold off
box on

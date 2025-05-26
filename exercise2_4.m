clear
global Re ue0 duedx

Re = 1e7;
ue0 = 1;
duedx = 0;

x0 = 0.01;
thick0(1) = 0.037*x0*(Re*x0)^(-1/5);
thick0(2) = 1.80*thick0(1);

[delx, thickhist] = ode45(@thickdash,[0 0.99],thick0);

x = x0 + delx;

theta7 = 0.037*delx.*(Re*delx).^(-1/5);
theta9 = 0.023*delx.*(Re*delx).^(-1/6);

figure; hold on
plot(x,thickhist(:,1), 'DisplayName', 'computed $\theta/L$')
plot(x,theta7, 'DisplayName', '$1/7^{th}$ power law estimate')
plot(x,theta9, 'DisplayName', '$1/9^{th}$ power law estimate')

xlabel('$x/L$', 'Interpreter', 'latex')
ylabel('$\theta/L$', 'Interpreter', 'latex')

legend('Interpreter', 'latex', 'FontSize', 16, 'Location', 'southeast')

ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 16) 
box on

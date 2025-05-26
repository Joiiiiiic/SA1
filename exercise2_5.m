clear
global Re ue0 duedx

Re = 1e7;
ue0 = 1;
duedx = -0.9;

x0 = 0.01;
thick0(1) = 0.037*x0*(Re*x0)^(-1/5);
thick0(2) = 1.80*thick0(1);

[delx, thickhist] = ode45(@thickdash,[0 0.99],thick0);

x = x0 + delx;

figure; hold on
plot(x,thickhist(:,1), 'DisplayName', '$\theta/L$')
plot(x,thickhist(:,2), 'DisplayName', '$\delta_E/L$')

xlabel('$x/L$', 'Interpreter', 'latex')

legend('Interpreter', 'latex', 'FontSize', 16, 'Location', 'best')

ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 16) 
box on


he = thickhist(:,2)./thickhist(:,1);
x_separate = interp1(he,x,1.46);

figure; hold on
plot(x, he)
yline(1.46,'--k')
xline(x_separate, '--k')
ylim([0 inf])

xlabel('$x/L$', 'Interpreter', 'latex')
ylabel('$H_E$', 'Interpreter', 'latex')

x_text = x(end) * 0.1; 
text(x_text, 1.46 + 0.05, '$H_E = 1.46$', ...
    'Interpreter', 'latex', 'FontSize', 16, 'Color', 'k')

ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 16) 
box on

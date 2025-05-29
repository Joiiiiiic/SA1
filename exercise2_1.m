clear 
close all

Re = 2500;
x = 0:0.01:1;
ue = ones(size(x));

f = ueintbit(x(1:end-1),ue(1:end-1),x(2:end),ue(2:end));
theta = sqrt(cumsum(f)*0.45/Re.*ue(2:end).^(-6));
theta = [0,theta];

% Blasius solution
theta_bla = 0.664/sqrt(Re)*sqrt(x);

figure; hold on
plot(x, theta, 'DisplayName', '$\theta/L$ from Thwaites solution')
plot(x, theta_bla, 'DisplayName', 'Blasius solution')

xlabel('$x/L$', 'Interpreter', 'latex')
ylabel('$\theta/L$', 'Interpreter', 'latex')

legend('Interpreter', 'latex', 'FontSize', 16, 'Location', 'southeast')

ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 16)      
box on
clear
global Re ue0 duedx

Re_list = [10^7];
Re_name = {'10^7'};
duedx_list = [-0.3, -0.6, -0.9];

x_separate = zeros(length(Re_list), length(duedx_list));

figure; hold on

for r = 1:length(Re_list)
    for u = 1:length(duedx_list)

        Re = Re_list(r);
        ue0 = 1;
        duedx = duedx_list(u);
        
        x0 = 0.01;
        thick0(1) = 0.037*x0*(Re*x0)^(-1/5);
        thick0(2) = 1.80*thick0(1);
        
        [delx, thickhist] = ode45(@thickdash,[0 0.99],thick0);
        
        x = x0 + delx;
        
        
        he = thickhist(:,2)./thickhist(:,1);
        x_separate(r,u) = interp1(he,x,1.46);
        
        plot(x, he, 'DisplayName', ['$Re_L = ', Re_name{r},'; \frac{d(u_e/U)}{d(x/L)} = ',num2str(duedx),'$'])

    end
end

p = yline(1.46,'--k', 'DisplayName', '');
p.Annotation.LegendInformation.IconDisplayStyle = 'off';

ylim([0 inf])
xlabel('$x/L$', 'Interpreter', 'latex')
ylabel('$H_E$', 'Interpreter', 'latex')
legend('Interpreter', 'latex', 'FontSize', 14, 'Location', 'best')
x_text = x(end) * 0.1; 
text(x_text, 1.46 + 0.05, '$H_E = 1.46$', ...
    'Interpreter', 'latex', 'FontSize', 16, 'Color', 'k')

ax = gca;
ax.TickLabelInterpreter = 'latex'; 
set(gca, 'FontSize', 16) 
box on

% % for duedx = -0.6, Re = 10^7 only
% 
% figure; hold on
% plot(x,thickhist(:,1), 'DisplayName', '$\theta/L$')
% plot(x,thickhist(:,2), 'DisplayName', '$\delta_E/L$')
% 
% xlabel('$x/L$', 'Interpreter', 'latex')
% legend('Interpreter', 'latex', 'FontSize', 16, 'Location', 'best')
% ax = gca;
% ax.TickLabelInterpreter = 'latex'; 
% set(gca, 'FontSize', 16) 
% box on
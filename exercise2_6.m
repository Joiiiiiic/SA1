clear 
close all

global Re ue0 duedx

ReL_list = [1e4, 1e5, 1e6, 1e7];
Re_name = {'10^4', '10^5', '10^6', '10^7'};


duedx = -0.25;
ue_start = 1;
He0 = 1.57258;

int = zeros(length(ReL_list), 1);
ils = zeros(length(ReL_list), 1);
itr = zeros(length(ReL_list), 1);
its = zeros(length(ReL_list), 1);

figure(1);
set(gcf, 'Position', [100, 100, 1000, 400]);

for k = 1:length(ReL_list)

    Re = ReL_list(k);
    disp(['At Re_L = ', Re_name{k}])

    x = 0:0.01:1;
    ue = ue_start+x*duedx;
    theta = zeros(1,length(x));
    He = zeros(1,length(x));
    delE = zeros(1,length(x));
    He(1) = He0;
    f = 0;
        
    laminar = true;
    i = 2;
    
    while laminar && i <= length(x)
        f = f+ueintbit(x(i-1),ue(i-1),x(i),ue(i));
        theta(i) = sqrt(f*0.45/Re*ue(i)^(-6));
        
        Rethet = Re*ue(i)*theta(i); 
        
        m = -Re*theta(i)^2*duedx;

        H = thwaites_lookup(m);
        He(i) = laminar_He(H);
        if log(Rethet) >= 18.4*He(i) - 21.74
            laminar = false;
            % disp([x(i) Rethet/1000])
            int(k) = x(i);
            disp(['Natural transition at ' num2str(x(i))])
        elseif m>= 0.09
            laminar = false;
            ils(k) = x(i);
            He(i) = 1.51509;
            disp(['Laminar separation at ' num2str(x(i))])
        end
        delE(i) = He(i)*theta(i);

        i = i+1;
    end
    

    while ~laminar && i <= length(x) && its(k)==0
        ue0 = ue(i-1);
        thick0 = [theta(i-1); delE(i-1)];
        [delx, thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
        theta(i) = thickhist(end,1);
        delE(i) = thickhist(end,2);
        He(i) = delE(i)/theta(i);
        if He(i) < 1.46
            its(k) = x(i);
            H = 2.803;
            He(i:end) = 1.46;
            disp(['Turbulent separation at ' num2str(x(i))])
        elseif He(i)> 1.58 && ils(k) ~= 0 && itr(k) == 0
            itr(k) = x(i);
            disp(['Turbulent reattachment at ' num2str(x(i))])
        end
        % thick0 = [theta(i); delE(i)];

        i = i+1;
    end
    

    while i <= length(x) && its(k)~=0
        theta(i) = theta(i-1)*(ue(i-1)/ue(i))^(H+2);
        i = i+1;
    end

    subplot(1,2,1); hold on
    plot(x, theta, 'DisplayName', ['$Re_L = ', Re_name{k},'$']);
    ylabel('$\theta/L$', 'Interpreter', 'latex')
    ax = gca;
    ax.TickLabelInterpreter = 'latex'; 
    set(gca, 'FontSize', 16) 
    box on
    xlabel('$x/L$', 'Interpreter', 'latex')
    legend('Interpreter', 'latex', 'FontSize', 14, 'Location', 'best')

    subplot(1,2,2); hold on
    plot(x, He, 'DisplayName', ['$Re_L = ', Re_name{k},'$']);
    ylabel('$H_E$', 'Interpreter', 'latex')
    ax = gca;
    ax.TickLabelInterpreter = 'latex'; 
    set(gca, 'FontSize', 16) 
    box on
    xlabel('$x/L$', 'Interpreter', 'latex')
    legend('Interpreter', 'latex', 'FontSize', 14, 'Location', 'southwest')
end


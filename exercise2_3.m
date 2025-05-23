clear 
close all

% ReL_list = [1e3, 1e4, 1e5];
ReL_list = logspace(3,8,500);
dudx_list = [-0.5];
ue_start = 1;

table = zeros(length(ReL_list), length(dudx_list), 2);

int = zeros(length(ReL_list), length(dudx_list));
ils = zeros(length(ReL_list), length(dudx_list));


for k = 1:length(ReL_list)
    for j = 1:length(dudx_list)
        ReL = ReL_list(k);
        dudx = dudx_list(j);

        x = 0:0.01:1;
        ue = 1+x*dudx;
        
        f = ueintbit(x(1:end-1),ue(1:end-1),x(2:end),ue(2:end));

        theta = zeros(size(x));
        theta(2:end) = sqrt(cumsum(f)*0.45/ReL.*ue(2:end).^(-6));
        
        Rethet = ReL.*ue.*theta; 
        
        m = -ReL*theta.^2*dudx;
        
        laminar = true;
        i = 1;
        
        while laminar && i < length(m)
            H = thwaites_lookup(m(i));
            He = laminar_He(H);
            if log(Rethet(i)) >= 18.4*He - 21.74
                laminar = false;
                disp([x(i) Rethet(i)/1000])
                int(k,j) = x(i);
                % disp(['Natural transition at ' num2str(x(i)) ...
                % ' with Rethet ' num2str(Rethet(i))])
            elseif m(i)>= 0.09
                laminar = false;
                ils(k,j) = x(i);
                % disp(['Laminar separation at ' num2str(x(i)) ...
                % ' with Rethet ' num2str(Rethet(i))])
            end

            i = i+1;
        end

    end
end

% 1.8e6: where it transitions instead of separate
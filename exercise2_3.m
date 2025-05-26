clear 
close all

ReL_list = [1e3, 1e4, 1e5];
% ReL_list = logspace(3,8,500);
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
        theta = zeros(1,length(x));
        
        laminar = true;
        i = 2;
        f = 0;
        
        while laminar && i < length(x)
            f = f+ueintbit(x(i-1),ue(i-1),x(i),ue(i));
            theta(i) = sqrt(f*0.45/ReL*ue(i)^(-6));
            
            Rethet = ReL*ue(i)*theta(i); 
            
            m = -ReL*theta(i)^2*dudx;

            H = thwaites_lookup(m);
            He = laminar_He(H);
            if log(Rethet) >= 18.4*He - 21.74
                laminar = false;
                disp([x(i) Rethet/1000])
                int(k,j) = x(i);
                disp(['Natural transition at ' num2str(x(i)) ...
                ' with Rethet ' num2str(Rethet)])
            elseif m>= 0.09
                laminar = false;
                ils(k,j) = x(i);
                disp(['Laminar separation at ' num2str(x(i)) ...
                ' with Rethet ' num2str(Rethet)])
            end

            i = i+1;
        end

    end
end

% 1.8e6: where it transitions instead of separate
clear 
close all

ReL_list = [1e6, 1e7, 1e8];
dudx_list = [-0.2,0,0.2];
ue_start = 1;

table = zeros(length(ReL_list), length(dudx_list), 2);

for k = 1:length(ReL_list)
    for j = 1:length(dudx_list)
        ReL = ReL_list(k);
        dudx = dudx_list(j);

        x = 0:0.01:1;
        ue = 1+x*dudx;
        
        f = ueintbit(x(1:end-1),ue(1:end-1),x(2:end),ue(2:end));
        theta = sqrt(cumsum(f)*0.45/ReL.*ue(2:end).^(-6));
        theta = [0,theta];
        
        Retheta = ReL.*ue.*theta; 
        
        m = -ReL*theta.^2*dudx;
        
        laminar = true;
        i =1;
        
        while laminar && i < length(m)
            H = thwaites_lookup(m(i));
            He = laminar_He(H);
            if log(Retheta(i)) >= 18.4*He - 21.74
                laminar = false;
                disp([x(i) Retheta(i)/1000])
                table(k,j,1) = x(i);
                table(k,j,2) = Retheta(i);
            end
            i = i+1;
        end
    end
end
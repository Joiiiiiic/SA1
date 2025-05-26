clear 
close all

ReL_list = [1e6, 1e7, 1e8];
dudx_list = [-0.2,0,0.2];
ue_start = 1;

table = zeros(length(ReL_list), length(dudx_list), 2);

x = 0:0.01:1;

for k = 1:length(ReL_list)
    for j = 1:length(dudx_list)
        ReL = ReL_list(k);
        dudx = dudx_list(j);

        ue = 1+x*dudx;
        theta = zeros(1,length(x));
        
        laminar = true;
        i = 2;
        
        f = 0;
        
        while laminar && i < length(x)
            f = f+ueintbit(x(i-1),ue(i-1),x(i),ue(i));
            theta(i) = sqrt(f*0.45/ReL.*ue(i).^(-6));
            
            Retheta = ReL*ue(i)*theta(i); 
            
            m = -ReL*theta(i)^2*dudx;

            H = thwaites_lookup(m);
            He = laminar_He(H);
            if log(Retheta) >= 18.4*He - 21.74
                laminar = false;
                disp([x(i) Retheta/1000])
                table(k,j,1) = x(i);
                table(k,j,2) = Retheta;
            end
            i = i+1;
        end
    end
end
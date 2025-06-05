function [int, ils, itr, its, delstar, theta] = bl_solv(x,cp)
%BL_SOLV Summary of this function goes here
%   Detailed explanation goes here

global Re ue0 duedx
He0 = 1.57258;

ue = sqrt(1-cp);
ue = [0,ue];
x = [0,x];

duedx_list = diff(ue)./diff(x);

int = 0;
ils = 0;
itr = 0;
its = 0;
theta = zeros(1,length(x)-1);
He = zeros(1,length(x));
delE = zeros(1,length(x));
delstar = zeros(1,length(x));
H = zeros(1,length(x));

He(1) = He0;
f = 0;

laminar = true;
i = 2;

while laminar && i <= length(x)
    duedx = duedx_list(i-1);
    f = f+ueintbit(x(i-1),ue(i-1),x(i),ue(i));
    theta(i-1) = sqrt(f*0.45/Re*ue(i)^(-6));

    Rethet = Re*ue(i)*theta(i-1); 

    m = -Re*theta(i-1)^2*duedx;

    H(i) = thwaites_lookup(m);
    He(i) = laminar_He(H(i));
    if log(Rethet) >= 18.4*He(i) - 21.74
        laminar = false;
        int = i-1;
    elseif m>= 0.09
        laminar = false;
        ils = i-1;
        He(i) = 1.51509;
    end
    delE(i) = He(i)*theta(i-1);

    i = i+1;
end


while ~laminar && i <= length(x) && its==0
    ue0 = ue(i-1);
    duedx = duedx_list(i-1);
    thick0 = [theta(i-2); delE(i-1)];
    [delx, thickhist] = ode45(@thickdash,[0,x(i)-x(i-1)],thick0);
    theta(i-1) = thickhist(end,1);
    delE(i) = thickhist(end,2);
    He(i) = delE(i)/theta(i-1);
    H(i) = (11*He(i)+15)/(48*He(i)-59);
    if He(i) < 1.46
        its = i-1;
        H(i:end) = 2.803;
        He(i:end) = 1.46;
    elseif He(i)> 1.58 && ils ~= 0 && itr == 0
        itr = i-1;
    end
    % thick0 = [theta(i); delE(i)];

    i = i+1;
end


while i <= length(x) && its~=0
    theta(i-1) = theta(i-2)*(ue(i-1)/ue(i))^(H(i)+2);
    i = i+1;
end

delstar = H(2:end).*theta;
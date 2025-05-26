function dthickdx = thickdash(xmx0,thick)
%compute dydx for solving pde later
global Re ue0 duedx

ue = ue0+xmx0*duedx;

theta = thick(1);
delE = thick(2);

Retheta = Re*ue*theta; 

he = delE/ theta;

if he >= 1.46
    h = (11*he+15)/(48*he-59);
else
    h = 2.803;
end

cf = 0.091448*((h-1)*Retheta)^(-0.232)*exp(-1.26*h);
c_diss = 0.010025*((h-1)*Retheta)^(-1/6);


f1 = cf/2-(h+2)/ue*duedx*theta;
f2 = c_diss - 3/ue*duedx*delE;

dthickdx = [f1; f2];

end
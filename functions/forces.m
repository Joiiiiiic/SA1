function [cl cd] = forces(circ,cp,delstarl,thetal,delstaru,thetau)

cl = -2*circ;
ue = sqrt(1-cp);

theta_te = thetal(te) + thetau(te);
delstar_te = delstarl(end) + delstaru(end);
H_te = delstar_te/theta_te;

theta_inf = theta_te*(ue(end))^((H_te + 5)/2)

cd = 2*theta_inf;

end
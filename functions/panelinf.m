function [infa, infb] = panelinf(xa,ya,xb,yb,xm,ym)
%Calculate influence coefficients for plate with ends (xa,ya) and (xb,ya). X
%and Y are vectorised.
t = [xb-xa,yb-ya];
del = norm(t);
t = t/norm(t);
n = [-t(2), t(1)];

X = (xm-xa) * t(1) + (ym-ya) * t(2);
Y = (xm-xa) * n(1) + (ym-ya) * n(2);

[infa, infb] = refpaninf(del,X,Y);


end
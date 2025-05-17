function [infa, infb] = panelinf(xa,ya,xb,yb,xm,ym)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
t = [xb-xa,yb-ya];
del = norm(t);
t = t/norm(t);
n = [-t(2)/t(1), 1];
n = n/norm(n);

r = cat(3,xm-xa, ym-ya);
X = r(:,:,1) * t(1) + r(:,:,2) * t(2);
Y = r(:,:,1) * n(1) + r(:,:,2) * n(2);

[infa, infb] = refpaninf(del,X,Y);


end
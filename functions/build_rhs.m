function rhsvec = build_rhs(xs,ys,alpha)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
psi = ys*cos(alpha) - xs*sin(alpha);

rhsvec = zeros(length(xs),1);
rhsvec(1:end-2) = - psi(1:end-2) + psi(2:end-1);

end
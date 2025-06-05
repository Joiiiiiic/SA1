function rhsvec = build_rhs(xs,ys,alpha)
%Build RHS vector b to calcualte strength of the discretised vortex sheet
psi = ys*cos(alpha) - xs*sin(alpha);

rhsvec = zeros(length(xs),1);
rhsvec(2:end-1) = psi(1:end-2)- psi(2:end-1);

end
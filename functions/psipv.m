function psixy = psipv(xc,yc,Gamma,x,y)
% Generate stream function for vortices at (xc, yc) with strength Gamma, note x and y are vectorised
r2 = (x-xc).^2+(y-yc).^2;
psixy = -Gamma/(4*pi)*log(r2);

end
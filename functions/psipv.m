function psixy = psipv(xc,yc,Gamma,x,y)
%Generate stream function for vortices
%   note x and y are matrices instead of a value as required
r2 = (x-xc).^2+(y-yc).^2;
psixy = -Gamma/(4*pi)*log(r2);

end
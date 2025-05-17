function [infa, infb] = refpaninf(del,X,Y)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [row, col] = find(abs(Y) < 1e-5);
    Y(row,col) = 1e-5;

    i0 = -1/(4*pi)*(X.*log(X.^2+Y.^2)-(X-del).*log((X-del).^2+Y.^2)-2*del+2*Y.*(atan(X./Y)-atan((X-del)./Y)));
    i1 = 1/(8*pi)*((X.^2+Y.^2).*log(X.^2+Y.^2)-((X-del).^2+Y.^2).*log((X-del).^2+Y.^2)-2.*X*del+del^2);
    
    infa = (1-X./del).*i0-i1./del;
    infb = X./del.*i0+i1./del;

end
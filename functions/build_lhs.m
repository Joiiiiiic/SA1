function lhsmat = build_lhs(xs,ys)
%Build LHS matrix A to calcualte strength of the discretised vortex sheet
np = length(xs) - 1;
psip = zeros(np,np+1); 

for j = 1:np
    [infa, infb] = panelinf(xs(j),ys(j),xs(j+1),ys(j+1),xs(1:end-1),ys(1:end-1));
    infa = infa(:);
    infb = infb(:);
    psip(:,j) = psip(:,j) + infa;
    psip(:,j+1) = psip(:,j+1) + infb;
end

lhsmat = zeros(np+1,np+1);
lhsmat(2:np,:) = psip(1:end-1,:)-psip(2:end,:);
lhsmat(1,1) = 1;
lhsmat(np+1,end) = 1;

end
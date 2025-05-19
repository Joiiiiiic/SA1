function lhsmat = build_lhs(xs,ys)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
np = length(xs) - 1;
psip = zeros(np,np+1); 

for j = 2:np
    [infa1, ~] = panelinf(xs(j),ys(j),xs(j+1),ys(j+1),xs(1:end-1),ys(1:end-1));
    [~, infb2] = panelinf(xs(j-1),ys(j-1),xs(j),ys(j),xs(1:end-1),ys(1:end-1));
    psip(:,j) = infa1+infb2;
end
[infa1, ~] = panelinf(xs(1),ys(1),xs(2),ys(2),xs(1:end-1),ys(1:end-1));
psip(:,1) = infa1;

[~, infb2] = panelinf(xs(np-1),ys(np-1),xs(np),ys(np),xs(1:end-1),ys(1:end-1));
psip(:,np+1) = infb2;

lhsmat = zeros(np+1,np+1);
lhsmat(1:np-1,:) = psip(1:end-1,:)-psip(2:end,:);
lhsmat(np,1) = 1;
lhsmat(np,end) = -1;
lhsmat(np+1,1) = 1;

end
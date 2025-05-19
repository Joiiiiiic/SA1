clear 
% close all

addpath('./functions')

%% Exercise 1

xmin = -2.5;
xmax = 2.5;
nx = 51;
ymin = -2;
ymax = 2;
ny = 41;
xc = 0.75;
yc = 0.5;
Gamma = 3;

x = linspace(xmin,xmax,nx);
y = linspace(ymin,ymax,ny);

[ym, xm] = meshgrid(y, x);


psi = psipv(xc,yc,Gamma,xm,ym);

c = -0.4:0.2:1.2;

figure
contour(xm,ym,psi,c)

%% Excercise 2

del = 1.5;

[infa, infb] = refpaninf(del,xm,ym);

c = -0.15:0.05:0.15;

figure
contour(xm,ym,infa,c)

figure
contour(xm,ym,infb,c)

% Discretised estimate for infa
nv = 100;

xpos = del/nv/2:del/nv:(del-del/nv/2);
gammaA = (1-1/del*xpos)*del/nv;
gammaB = (1/del*xpos)*del/nv;

infaEst = zeros(size(xm));
infbEst = infaEst;

for i = 1:length(xpos)
    infaEst = infaEst+psipv(xpos(i),0,gammaA(i),xm,ym);
    infbEst = infbEst+psipv(xpos(i),0,gammaB(i),xm,ym);
end

figure
contour(xm,ym,infaEst,c)

figure
contour(xm,ym,infbEst,c)

%% excercise 3
xa = 4.1; ya = 1.3; xb = 2.2; yb = 2.9;
del = norm([xb-xa,yb-ya]);

x = linspace(0,5,50);
y = linspace(0,4,40);

[ym, xm] = meshgrid(y, x);

[infa, infb] = panelinf(xa,ya,xb,yb,xm,ym);

c = -0.15:0.05:0.15;

figure
contour(xm,ym,infa,c)

figure
contour(xm,ym,infb,c)

% Discretised estimate for infa
nv = 100;

xpos = linspace(xa,xb,nv+1);
xpos = 0.5*(xpos(1:end-1)+xpos(2:end));
ypos = linspace(ya,yb,nv+1);
ypos = 0.5*(ypos(1:end-1)+ypos(2:end));

gammaA = linspace(1-1/(2*nv),1/(2*nv),nv)*del/nv;
gammaB = linspace(1/(2*nv),1-1/(2*nv),nv)*del/nv;

infaEst = zeros(size(xm));
infbEst = infaEst;

for i = 1:nv
    infaEst = infaEst+psipv(xpos(i),ypos(i),gammaA(i),xm,ym);
    infbEst = infbEst+psipv(xpos(i),ypos(i),gammaB(i),xm,ym);
end

figure
contour(xm,ym,infaEst,c)

figure
contour(xm,ym,infbEst,c)

%% excercise 4
np = 100;
theta = (0:np)*2*pi/np;
% create array of vortex positions
for i = 1:(np+1)
xs(i) = cos(theta(i));
ys(i) = sin(theta(i));
gamma(i)=-2*sin(theta(i));
end
% calculate influence at each point
for i = 1:nx
for j = 1:ny
xm(i,j) = xmin+(i-1)*(xmax-xmin)/(nx-1);
ym(i,j) = ymin+(j-1)*(ymax-ymin)/(ny-1);
psi(i,j) = ym(i,j);
% nested loop to add each panel's contributions to streamfunction
for k = 1:np
[infa(i,j), infb(i,j)] = panelinf(xs(k), ys(k), xs(k+1), ys(k +1), xm(i,j), ym(i,j));
gammaa = gamma(k);
gammab = gamma(k+1);
psi (i,j) = psi(i,j)+(gammaa*infa(i,j))+(gammab*infb(i,j));
end
end
end
% plot contours
c = -1.75:0.25:1.75;
figure
contour(xm, ym ,psi ,c)

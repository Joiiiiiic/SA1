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

[ym2, xm2] = meshgrid(y, x);

[infa, infb] = panelinf(xa,ya,xb,yb,xm2,ym2);

c = -0.15:0.05:0.15;

figure
contour(xm2,ym2,infa,c)

figure
contour(xm2,ym2,infb,c)

% Discretised estimate for infa
nv = 100;

xpos = linspace(xa,xb,nv+1);
xpos = 0.5*(xpos(1:end-1)+xpos(2:end));
ypos = linspace(ya,yb,nv+1);
ypos = 0.5*(ypos(1:end-1)+ypos(2:end));

gammaA = linspace(1-1/(2*nv),1/(2*nv),nv)*del/nv;
gammaB = linspace(1/(2*nv),1-1/(2*nv),nv)*del/nv;

infaEst = zeros(size(xm2));
infbEst = infaEst;

for i = 1:nv
    infaEst = infaEst+psipv(xpos(i),ypos(i),gammaA(i),xm2,ym2);
    infbEst = infbEst+psipv(xpos(i),ypos(i),gammaB(i),xm2,ym2);
end

figure
contour(xm2,ym2,infaEst,c)

figure
contour(xm2,ym2,infbEst,c)

%% excercise 4
np = 100;
theta = (0:np)*2*pi/np;
xs = cos(theta);
ys = sin(theta);
gamma = -2*sin(theta);

psi = ym;

% nested loop to add each panel's contributions to streamfunction
for k = 1:np
[infa, infb] = panelinf(xs(k), ys(k), xs(k+1), ys(k +1), xm, ym);
gammaa = gamma(k);
gammab = gamma(k+1);
psi = psi+(gammaa*infa)+(gammab*infb);
end


% plot contours
c = -1.75:0.25:1.75;
figure
contour(xm, ym ,psi ,c)

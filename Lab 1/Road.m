%Uppgift 3a

xA = [175, 410, 675]';
yA = [950, 2400, 1730]';

xB = [160, 381, 656]';
yB = [1008, 2500, 1760]';

LA = [60, 75, 42]';
LB = [45, 88, 57]';

% funktion
g = @(x,y,xA,yA,xB,yB,LA,LB) [
    (x - xA)^2 + (y - yA)^2 - LA^2;
    (x - xB)^2 + (y - yB)^2 - LB^2;
];

% Jacobian matrix (2x2)
Jg = @(x,y,xA,yA,xB,yB) [
    2 * (x - xA), 2 * (y - yA);
    2 * (x - xB), 2 * (y - yB);
];

% Startgissning för p1 p2 och p3
x = [200, 460, 700]'; 
y = [1000, 2500, 1700]';

% tolerans
tol = 1e-11;

% Final, spara värderna
xrot = zeros(3,1);
yrot = zeros(3,1);

% Loopa över (P1, P2, P3) och xA yA xB yB LA och LB
for i = 1:3    
    xi = x(i);
    yi = y(i);

    xa= xA(i);
    xb=xB(i);
    ya=yA(i);
    yb=yB(i);
    La = LA(i);
    Lb = LB(i);
    
    hnorm = 1; 
    iter = 0; 
    diffx = [];

    while hnorm > tol && iter < 20
        iter = iter + 1;
        J = Jg(xi,yi,xa,ya,xb,yb);
        g_val = g(xi,yi,xa,ya,xb,yb,La,Lb); % funktionens värden

            h = -J \ g_val; 
            xi = xi + h(1);  
            yi = yi + h(2);  
            hnorm = norm(h);
            diffx = [diffx, hnorm];
        
    end

    % Spara värderna
    xrot(i) = xi;
    yrot(i) = yi;
end

% Utskrift av resultatet
disp('x och y koordinater för P1 P2 och P3');
disp([xrot, yrot]);

figure;
semilogy(1:length(diffx), diffx,'LineWidth',1);
xlabel('iterationer')
ylabel('Normen')
title('Konvergenshastighet');

% Vad blir koordinaterna? => P1(204.6, 1002.2) P2 = (458.1, 2457.6) P3=
% (712.1,1749.7)
%Hur kan du förvissa dig om att Newtons metod konvergerar = > I grafen syns
%det tydligt att newtons metod konvergerar som den ska?
% Vilken konvergenshastighet ser du? => Kvadrtiskt minskning

% ____________----------_____________---------------_____________------------_________________------------
% Uppgift 3b

%Ansats: P = c0+c1x+c2x^2+c3x^3+c4^x^4
% Ac=b
P0=[0;0];
P4=[1020;0];
rot_y = [P0(2), yrot(1), yrot(2), yrot(3), P4(2)]';
rot_x = [P0(1), xrot(1), xrot(2), xrot(3), P4(1)]';
d = length(rot_y);


A1 = [ones(d, 1), rot_x, rot_x.^2, rot_x.^3, rot_x.^4];

disp('Koefficienterna')
c=A1\rot_y


p = @(x) c(1) + c(2).*x + c(3).*x.^2 + c(4).*x.^3 + c(5).*x.^4;


figure;
grid on;
fplot(p,[0,1020],'LineWidth',1);
hold on;
plot(rot_x,rot_y,'o','LineWidth',2)
xlabel('x-koordinater')
ylabel('ykoordinater')
title('Interpolation');

disp('c5')
fprintf("%.10f\n",c(5))


% Koefficienterna blir c0=0, c1= -0.5836, c2 = -0.0417, c3 = -0.0001 och c4 = 0.0000000397

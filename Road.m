%Uppgift 3a

xA = [175, 410, 675]';
yA = [950, 2400, 1730]';

xB = [160, 381, 656]';
yB = [1008, 2500, 1760]';

LA = [60, 75, 42]';
LB = [45, 88, 57]';

% Function for nonlinear system
g = @(x,y,xA,yA,xB,yB,LA,LB) [
    (x - xA)^2 + (y - yA)^2 - LA^2;
    (x - xB)^2 + (y - yB)^2 - LB^2;
];

% Jacobian matrix (2x2)
Jg = @(x,y,xA,yA,xB,yB) [
    2 * (x - xA), 2 * (y - yA);
    2 * (x - xB), 2 * (y - yB);
];

% Initial guesses
x = [200, 460, 700]';
y = [1000, 2500, 1700]';

% Tolerance
tol = 1e-11;

% Store results
xrot = zeros(3,1);
yrot = zeros(3,1);

% Loop over each point (P1, P2, P3)
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
        g_val = g(xi,yi,xa,ya,xb,yb,La,Lb); % Get function values

            h = -J \ g_val; 
            xi = xi + h(1);  
            yi = yi + h(2);  
            hnorm = norm(h);
            diffx = [diffx, hnorm];
        
    end

    % Store results
    xrot(i) = xi;
    yrot(i) = yi;
end

% Display results
disp('x och y koordinater för P1 P2 och P3');
disp([xrot, yrot]);

figure;
semilogy(1:length(diffx), diffx,'LineWidth',1);
xlabel('iterationer')
ylabel('Normen')
title('Konvergenshastighet');


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


fprintf("%.10f\n",c(5))


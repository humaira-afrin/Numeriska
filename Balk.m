% Uppgift 2a Newtons metod (har lite problem med startgissning)
H = 0.5;
f = @(x) 8 * exp(-x/2) * cos(3 * x) - H; % funktionen
fp = @(x) -4 * exp(-x/2) * cos(3 * x) - 24 * exp(-x/2) * sin(3 * x); % derivatan av funktionen

x = 4.49; % Startgissning (måste ändras för nu divergerar funtionen wierd)
tol = 1e-8; % Tolerans
diffx = 1; iter = 0; maxiter = 100;
res_newton=[];%uppgift 2c

while diffx > tol && iter < maxiter % sålänge diff är större än tolerasen
    iter = iter + 1; % öka antal iterationer
    xnew = x - (f ( x ) / fp ( x )) ; % Räkna xn+1=xn-(f(x)/f'(x)) 
    diffx = abs ( xnew - x ) ; % skillnaden/längden mellan två pinkter:  | x ( n +1) -x ( n ) |
    res_newton=[res_newton,diffx];
    x = xnew ; % Uppdatera xn med värdet av xn+1, alltså stargissningen uppdateras
    disp ([ iter xnew diffx ]) % Utskrift pa skarmen
 end
T_newton=x %resultat


%---------_________________-----------------_______________________-----------------------___________________

% Uppgift 2b : Secant method (funkar bra)
H=0.5;
g = @(x) 8 * exp(-x/2) * cos(3 * x) - H; % funitionen
% Startgissning
h0 = 4; 
h1 = 5;
tol = 1e-8; % tolerans
diffx = 1; % differensen
iter = 0; % antal iterationer
maxiter = 100;
res_sekant=[]; % uppgift 2c

while diffx > tol && iter < maxiter % sålänge differensen är större än toleransen
    iter = iter + 1; % Increment iteration 
    hnew = h1 - g(h1) * ((h1 - h0) / (g(h1) - g(h0))); % räkna xn+1 = xn-f(xn)*(x-xn)/f(xn)-f(x0) här är xn =h1 och x= h0
    diffx = abs(hnew - h1); % skillnaden/längden mellan två pinkter:  | x ( n +1) -x ( n ) |
    res_sekant=[res_sekant,diffx];
    h0 = h1;  % uppdatera så att i andra iteration x=h1
    h1 = hnew; % uppdatera så att i andra iteration xn = xn+1 alltså den nya x värdet
    disp([iter, hnew, diffx]); 
end
T_sekant = h1

%---------------________________------------______________---------------______________---------------------

%Uppgift 2c: Jämför konvergenshastigheten

figure;
semilogy(1:length(res_sekant), res_sekant,'LineWidth',2);
hold on;
semilogy(1:length(res_newton), res_newton, 'LineWidth',2);
grid on;
xlabel('Iterationer (n)');
ylabel('|h_{n+1} - h_n|');
title('Konvergenshastighet');
legend('Sekant', 'Newton');


%________----------------_________________------------------___________________------------------------_____

% Uppgift 2d (måste fixa probelemt med startgissning, samma problem som i 2a)
H = 2.8464405473 ; % byt H = 2.8464405473 
v = @(x) 8 * exp(-x/2) * cos(3 * x) - H; % funktionen
vp = @(x) -4 * exp(-x/2) * cos(3 * x) - 24 * exp(-x/2) * sin(3 * x); % derivatan av funktionen

x = 0.4; % Startgissning (måste ändras för nu divergerar funtionen wierd)
tol = 1e-8; % Tolerans
diffx = 1; iter = 0; maxiter = 100;

while diffx > tol && iter < maxiter % sålänge diff är större än tolerasen
    iter = iter + 1; % öka anta iterationer
    xnew = x - (v ( x ) / vp ( x )) ; % Räkna xn+1=xn-(f(x)/f'(x)) 
    diffx = abs ( xnew - x ) ; % skillnaden/längden mellan två pinkter:  | x ( n +1) -x ( n ) |
    x = xnew ; % Uppdatera xn med värdet av xn+1, alltså stargissningen uppdateras
    disp ([ iter xnew diffx ]) % Utskrift pa skarmen
 end
TN=x %resultat

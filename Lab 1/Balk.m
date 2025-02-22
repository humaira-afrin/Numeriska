% Uppgift 2a Newtons metod 
H = 0.5;
f = @(x) 8 * exp(-x/2) * cos(3 * x) - H; % funktionen
fp = @(x) -4 * exp(-x/2) * cos(3 * x) - 24 * exp(-x/2) * sin(3 * x); % derivatan av funktionen

x = 4.49; % Startgissning 
tol = 1e-8; % Tolerans
diffx = 1; iter = 0; maxiter = 100;
res_newton=[];% uppgift 2c

while diffx > tol && iter < maxiter % 
    iter = iter + 1; % öka antal iterationer
    xnew = x - (f ( x ) / fp ( x )) ; % Räkna xn+1=xn-(f(x)/f'(x)) 
    diffx = abs ( xnew - x ) ; % skillnaden/längden mellan två pinkter:  | x ( n +1) -x ( n ) |
    res_newton=[res_newton,diffx];
    x = xnew ; % Uppdatera xn med värdet av xn+1, alltså stargissningen uppdateras
    disp ([ iter xnew diffx ]) % Utskrift pa skarmen
 end
T_newton=x %resultat

% Startgissningen är 4.49
% Antal iterationer blev 3
% Resultatet blev T = 4.5007
%---------_________________-----------------_______________________-----------------------___________________

% Uppgift 2b : Secant method 
H=0.59;
g = @(x) 8 * exp(-x/2) * cos(3 * x) - H; % funitionen
% Startgissning
h0 = 4; 
h1 = 5;

tol = 1e-8; % tolerans
diffx = 1; % differensen
iter = 0; % antal iterationer
maxiter = 100;
res_sekant=[]; % uppgift 2c

while diffx > tol && iter < maxiter 
    iter = iter + 1; % Increment iteration 
    hnew = h1 - g(h1) * ((h1 - h0) / (g(h1) - g(h0))); % räkna xn+1 = xn-f(xn)*(x-xn)/f(xn)-f(x0) här är xn =h1 och x= h0
    diffx = abs(hnew - h1); % skillnaden/längden mellan två pinkter:  | x ( n +1) -x ( n ) |
    res_sekant=[res_sekant,diffx];
    h0 = h1;  % uppdatera så att i andra iteration x=h1
    h1 = hnew; % uppdatera så att i andra iteration xn = xn+1 eller hnew alltså den nya x värdet
    disp([iter, hnew, diffx]); 
end
T_sekant = h1

%Vilka startvärden har använts? => startvärdena h0=4 och h1 = 4
% Hur många iterationer krävdes => Totalkt krävdes 7 iterationer
% vad blev resultatet? => Resultatet böev T = 4.5007
% Behövs det fler eller färre steg med sekantmetoden för att nå
% ett fel som är mindre än 10−8 än med Newtons metod? => Det behövs fler
% steg i sekant metod jämfört med Netons metod
%Varför är det på det ena eller andra sättet? = > Newtons method får vi den
%exakta lutningen vid en punkt iom att vi har med första derivatan a
%funktionen men i seknats method vlir det en approximation av derivatan.


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

% Uppgift 2d 
H = 2.8464405473 ; % byt H = 2.8464405473 
v = @(x) 8 * exp(-x/2) * cos(3 * x) - H; % funktionen
vp = @(x) -4 * exp(-x/2) * cos(3 * x) - 24 * exp(-x/2) * sin(3 * x); % derivatan av funktionen

x = 2.05; % Startgissning 
tol = 1e-8; % Tolerans
diffx = 1; iter = 0; maxiter = 100;
res2 = [];
while diffx > tol && iter < maxiter 
    iter = iter + 1; % öka anta iterationer
    xnew = x - (v ( x ) / vp ( x )) ; % Räkna xn+1=xn-(f(x)/f'(x)) 
    diffx = abs ( xnew - x ) ; % skillnaden/längden mellan två pinkter:  | x ( n +1) -x ( n ) |
    res2=[res2,diffx];
    x = xnew ; % Uppdatera xn med värdet av xn+1, alltså stargissningen uppdateras
    disp ([ iter xnew diffx ]) % Utskrift pa skarmen
 end
TN=x %resultat
figure;
fplot(v,[0,10])
grid on

%Studera kon-vergenshastighet och känsligheten vad gäller val av startgissning. jämfört med a) på? 
% => minsta ändring i stargissning i uppgift a kan minska antal iterationer
% drastiskt men inte i sekant metoden
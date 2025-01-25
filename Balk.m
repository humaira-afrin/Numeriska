% Definiera funktion och dess derivata
H = 0.5;
f = @(x) 8 * exp(-x/2) * cos(3 * x) - H;
fp = @(x) -4 * exp(-x/2) * cos(3 * x) + 24 * exp(-x/2) * sin(3 * x);

x = 5; % Startgissning
tol = 1e-8; % Tolerans
diffx = 1; iter = 0; maxiter = 100;

while diffx > tol && iter < maxiter
    iter = iter + 1; % Antal iterationer - n
    xnew = x - f ( x ) / fp ( x ) ; % Uppdatering med Newton
    diffx = abs ( xnew - x ) ; % | x ( n +1) -x ( n ) |
    x = xnew ;
    disp ([ iter xnew diffx ]) % Utskrift pa skarmen
 end
Th=xnew

 % sekant metoden 
H=0.5;
g = @(x) 8 * exp(-x/2) * cos(3 * x) - H;

% Startgissning
h0 = 4; 
h1 = 5;

tol = 1e-8;
diffx = 1; 
iter = 0;
maxiter = 100;

% Secant method loop
while diffx > tol && iter < maxiter
    iter = iter + 1; % Increment iteration count
    hnew = h1 - g(h1) * ((h1 - h0) / (g(h1) - g(h0))); 
    diffx = abs(hnew - h1);
    h0 = h1;
    h1 = hnew;
    disp([iter, hnew, diffx]); 
end
T = hnew;

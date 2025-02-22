clear all

function T = trapets(f,a,b,beta,h) % Beräknar integration med trapetsmetoden
    for i = 1:length(h)   
        hi = h(i);       % Steglängd
        N = (b-a)/hi;    % Antal intervall
        x = linspace(a,b,N+1);  % Kan också skrivas som x = 0:h:1;

        fx = f(x,beta); % Räknar ut funktionen i x-värdena (och beta)

        y(i) = hi*(sum(fx)-0.5*(fx(1)+fx(end))); % Trapetsregeln
        V(i) = pi * y(i); % Volymen
    end
    T = V(1:end); % Vektor med volymen vid olika h
end

function S = simpson(f,a,b,beta,h) % Beräknar integration med simpsons metod
    for i = 1:length(h)
        hi = h(i); % Steglängd
        x = a:hi:b;

        fx = f(x,beta); % Räknar ut funktionen i x-värdena (och beta)

        y(i) = hi/3*(fx(1) + 4*sum(fx(2:2:end-1)) + 2*sum(fx(3:2:end-2)) + fx(end)); % Sekantmetoden
        V(i) = pi * y(i); % Volymen
    end
    S = V(1:end); % Vektor med volymen vid olika h
end

% Anonym funktion av funktionen innanför integralen
f = @(x,beta) ((exp(beta.*x)+8)./(1+(x./5).^3)).^2; % f(x,beta) = y(x;beta)^2

a = 0; b = 20;  % Nedre och övre integrationsgränser
beta = 0.2;     % Given data
h = 1 ./ 2.^(4:6); % h kommer at börja med 1/16 och halveras i varje steg till 1/64. Alltså 1/16, 1/32, 1/64

T = trapets(f,a,b,beta,h); % Räknar ut V med trapetsmetoden (vid tre olika h (1/16, 1/32, 1/64))
T_kvot = abs(T(2:end-1) - T(1:end-2)) ./ abs(T(3:end) - T(2:end-1)); % Kontrollerar nogranhetssordningen

S = simpson(f,a,b,beta,h); % Räknar ut V med Simpsons metod (vid tre olika h (1/16, 1/32, 1/64))
S_kvot = abs(S(2:end-1) - S(1:end-2)) ./ abs(S(3:end) - S(2:end-1)); % Kontrollerar nogranhetssordningen

disp(['Trapetsmetoden: V = ', num2str(T(end))]) % Visa volymen vid sista beräkning med trapetsmetoden
disp('Nogrannhetsordning för Trapets: '); disp(T_kvot') % Visa nogrannhetssordning med trapetsmetoden

disp(['Simpsons metod: V = ', num2str(S(end))]) % Visa volymen vid sista beräkning med simpsons metod
disp('Nogrannhetsordning för Simpsons: '); disp(S_kvot')  % Visa nogrannhetssordning med simpsons metod
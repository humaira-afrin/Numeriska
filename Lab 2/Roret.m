clear all

% Funktionen används i uppgift c) och beräknar värden på T
function [A,b,ri,N,T,TN1] = diskretisering_temperatur(N,alfa,k,r0,rN1,Te,T0)
    tol = 0.1;
    TN1_old = Te; % Initial guess
    err = 1; % Initierar error. 1 har ingen mening
    
    % Loppen behövs för att testa olika N värden och nogrannheten
    while err > tol
        h = 1/(N+1);    % Steglängd 
        ri = [r0+h:h:rN1-h]';   %Inre punkter (r1, r2, r3, r4 ...) 
    
        A = zeros(N,N);     % Sätter upp matris A
        A(1,1:2) = [(-2*ri(1))/(h^2)  ri(1)/(h^2)+1/(2*h)];   % Första raden
        
        % Loopar igenom olika i för att beräkna vad Ti blir med hjälp av
        % finita differensmetoden (centrala differenser)
        for i = 2:N-1
            A(i,i-1) = ri(i)/(h^2) - 1/(2*h);   % T_(i-1)
            A(i,i) = (-2*ri(i))/(h^2);            % T_(i)
            A(i,i+1) = ri(i)/(h^2) + 1/(2*h);   % T_(i+1)
        end

        A(N,N-1:N) = [ri(N)/(h^2)-1/(2*h)  (-2*ri(N))/(h^2)+(k*ri(N))/(k*(h^2)+alfa*h^3)+k/(k*2*h+2*alfa*h^2)]; % Sista raden
        A = sparse(A); % Spara den som gles matris

        b = zeros(N,1); % Sätter upp matris b

        b(1) = T0/(2*h) - (T0*ri(1))/(h^2);  % Anger värdet på första input (vad T1 är)
        b(N) = -((Te*alfa*h)/(k+alfa*h))*(ri(N)/(h^2)+1/(2*h)); % Anger värdet på sista input (vad T_N är)

        T = A\b; % Räknar ut värden på T_1, T_2, T_3, ... T_N

        TN1 = (Te*alfa*h + T(N)*k) / (k + alfa*h); % Räknar ut värden på T_(N+1)
        err = abs(TN1-TN1_old); % Räknar ut vad felet är (skillnaden mellan nya T_(N+1) och gamla T_(N+1)
        TN1_old = TN1; % Förnyar gamla värdet på T_(N+1)
        N = 2 * N;
    end
    N = N/2; % I slutet av while-loopen multiplicerades den onödigt och vi vill få det rätta värdet
end

% Funktionen används i uppgift d) och beräknar T_(N+1)
function TN1 = diskretisering_temperatur_alfa(N,alfa,k,r0,rN1,Te,T0)
        h = 1/(N+1);    % Steglängd 
        ri = [r0+h:h:rN1-h]';   %Inre punkter (r1, r2, r3, r4 ...) 
    
        A = zeros(N,N);     % Sätter upp matris A
        A(1,1:2) = [(-2*ri(1))/(h^2)  ri(1)/(h^2)+1/(2*h)];   % Första raden

        % Loopar igenom olika i för att beräkna vad Ti blir med hjälp av
        % finita differensmetoden (centrala differenser)
        for i = 2:N-1
            A(i,i-1) = ri(i)/(h^2) - 1/(2*h);   % T_(i-1)
            A(i,i) = (-2*ri(i))/(h^2);            % T_(i)
            A(i,i+1) = ri(i)/(h^2) + 1/(2*h);   % T_(i+1)
        end

        A(N,N-1:N) = [ri(N)/(h^2)-1/(2*h)  (-2*ri(N))/(h^2)+(k*ri(N))/(k*(h^2)+alfa*h^3)+k/(k*2*h+2*alfa*h^2)]; % Sista raden
        A = sparse(A); % Spara den som gles matris

        b = zeros(N,1); % Sätter upp matris b

        b(1) = T0/(2*h) - (T0*ri(1))/(h^2); % Anger värdet på första input (vad T1 är)
        b(N) = -((Te*alfa*h)/(k+alfa*h))*(ri(N)/(h^2)+1/(2*h)); % Anger värdet på sista input (vad T_N är)

        T = A\b;  % Räknar ut värden på T_1, T_2, T_3, ... T_N

        TN1 = (Te*alfa*h + T(N)*k) / (k + alfa*h); % Räknar ut värden på T_(N+1)
        
end

% Börjar med uppgift c)
N = 25;              % Delintervall
alfa = 1;
k = 1; 
Te = 20;
r0 = 1; rN1 = 2;     % Randpunkter
T0 = 450;       % Första randvärde

[A,b,ri,N,T,TN1] = diskretisering_temperatur(N,alfa,k,r0,rN1,Te,T0); % Anropar funktionen

rx = [r0; ri; rN1]; % En vektor med värdena r_0, r_1, r_2, ..., r_N, r_(N+1)
Ty = [T0; T; TN1]; % En vektor med värden T_0, T_1, T_2, ..., T_N, T_(N+1)

% Rita temperaturfördelningen
figure;
plot(rx, Ty, '-o', 'LineWidth', 1);
xlabel('r');
ylabel('T');
title('Temperaturfördelning i cylinderväggen');
grid on;

fprintf('Sista N värde: %d\n', N);
fprintf('Sista T värde: %.2f\n', TN1);

% Börjar med uppgift d) 
N = 10000;      % Delintervall
alfa_values = linspace(0, 10, 20); % alfa värden: 20 intervall
TN1_values = zeros(size(alfa_values)); % T_(N+1) värden vid olika alfa värden

% Loopa över alfa-värden
for i = 1:length(alfa_values)
    alfa = alfa_values(i);
    TN1_values(i) = diskretisering_temperatur_alfa(N, alfa, k, r0, rN1, Te, T0);
end

% Rita temperaturfördelningen
figure;
plot(alfa_values, TN1_values, '-o', 'LineWidth', 1);
xlabel('\alpha');
ylabel('T_{N+1}');
title('Temperatur vid rörledningens ytterradie');
grid on;

% När alfa ökar så minskar T_(N+1) (temperatur vid ytterradie)
% Om alfa går mot oändligheten, kommer T_(N+1) gå mot Te

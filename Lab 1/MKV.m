clear all
load STHLMTEMP;

% Uppgift 1a
% Parameter
k = 2*pi/365;
d = length(Tdm); % Antal dagar
t = (1:d)'; % En vektor av antal dagar (från 1 till d (dagar))

A = [ones(d,1), sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];
Amkv= A'*A;

c = Amkv \ (A'*Tdm);

% Visa koefficienterna
fprintf('Modell 1 koefficienter:\n');
fprintf('c0 = %.4f\n', c(1));
fprintf('c1 = %.4f\n', c(2));
fprintf('c2 = %.4f\n', c(3));
fprintf('c3 = %.4f\n', c(4));
fprintf('c4 = %.4f\n', c(5));

modell = @(t) c(1) + c(2)*sin(k*t) + c(3)*cos(k*t) + c(3)*sin(2*k*t) + c(4)*cos(2*k*t);

p = modell(t);


 % __________---------------________________-----------------____________________---------------_________________

 % Uppgift 1b

 % Modellens temperaturvärden
Tmod = A*c;

% Residual
residual = Tdm - Tmod;
% Minstakvadratsumman som beräknas med sigma
minstakvadratsumma = sum(residual.^2)


% ritar upp modell 1 och data
figure;
subplot(2, 1, 1);
plot(t,Tdm);
hold on;
plot(t,p);
hold off;
legend("Data","Modell 1")
xlabel("t");
ylabel("T(t)");
title("Uppmätta temperaturer")

% Ritar upp residualen av modell 1
subplot(2, 1, 2);
plot(t,residual);
legend("Residualer");
xlabel("t");
ylabel("Residual");
title("Residualer av uppmätta temperaturer")


%________________------------------___________________------------------------________________________--------------

% uppgift 1c

A2 = [ones(d,1), t, t.^2, sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];
a = A2 \ Tdm;
% Visa koefficienterna
fprintf('Modell 2 koefficienter:\n');
fprintf('a0 = %.4f\n', a(1));
fprintf('a1 = %.4f\n', a(2));
fprintf('a2 = %.4f\n', a(3));
fprintf('a3 = %.4f\n', a(4));
fprintf('a4 = %.4f\n', a(5));
fprintf('a5 = %.4f\n', a(6));
fprintf('a6 = %.4f\n', a(7));

modell2 = @(t) a(1) + a(2)*t + a(3)*(t.^2) + a(4)*sin(k*t) + a(5)*cos(k*t) + a(6)*sin(2*k*t) + a(7)*cos(2*k*t);

p2 = modell(t);


%________---------------_____________-----------_______--------_____----------______-------________------_______-----

% Uppgift 1d
% Modellens temperaturvärden
Tmod2 = A2*a;

% Residual
residual2 = Tdm - Tmod2;

% Minstakvadratsumman som beräknas med sigma
minstakvadratsumma2 = sum(residual2.^2)

figure;
subplot(2, 1, 1);
plot(t,Tdm);
hold on;
plot(t,p);
hold off;
legend("Data","Modell 2")
xlabel("t");
ylabel("T(t)");
title("Uppmätta temperaturer");

subplot(2, 1, 2);
plot(t,residual);
legend("Residualer");
xlabel("t");
ylabel("Residual");
title("Residualer av uppmätta temperaturer");


% Minstakvadratsumman är lägre i den andra andra modellen jämfört med den
% första. Det betyder att passformen är bättre. Att residualer har en
% mindre spridning (som vi ser i modell 2) betyder också att den nya
% modellen är bättre. 

%__________-----------_________-------------___________-------_______----------___________-------___________-------______


% Temperaturen har ökat under perioden 1756-2024. Ökningen accelererade. 
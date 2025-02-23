% a

% q'' = -R/L q' - 1/CL q
% q'' = -R/L i  -1/CL j
%i = q' --> i' = -R/L i -1/CL j
% y = [ q;i]
% q'' = -R/L y(2) -1/CL y(1)

%F = @(y) [y(2); -(R/L)*y(2) - (1/(C*L))* y(1)]; % y' = F(t,y)

% q(0) = 1
% q'(0) = i(0) = 0
% y0 = [1;0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% b
function func = los(t, y, R, L, C)
    func = [y(2);  % q' = i
            - (R/L) * y(2) - (1/(C*L)) * y(1)]; % i' = -R/L * i - 1/(CL) * q        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%c

L = 2;
C = 0.5;
R = [1,0];
tspan = [0 20];
y0 = [1;0];
[t1,y1] = ode45(@(t,y) los(t,y,R(1),L,C), tspan, y0)
[t2,y2] = ode45(@(t,y) los(t,y,R(2),L,C), tspan, y0)

figure;
plot(t1, y1(:,1), 'b-', 'LineWidth', 1.5, 'DisplayName', 'R = 1');
hold on;
plot(t2, y2(:,1), 'r--', 'LineWidth', 1.5, 'DisplayName', 'R = 0');
hold off;
xlabel('Time (s)');
ylabel('q(t)');
title('q vs t för olika resistans R');
legend;
grid on;

% Eftersom R = 1 har vi en resistans så svängingen borde avta över tid som
% det gör (se blåa grafen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%d
tspan=[0,40];
N = [40,80,160,320];
L=2;
C= 0.5;
R=1;
results = cell(length(N), 1); % för att spara y för alla N
tVecs = cell(length(N), 1);  % Store time vectors


for i=1 : length(N)
    h = tspan(2)/N(i);
    y = [1;0];
   t = tspan(1):h:tspan(2);
    Y = zeros(length(y),length(t));
    Y(:,1)=y;

    for ii =1 : N(i)
        y = y + h * los(t(ii),y,R,L,C);
         Y(:,ii+1)=y;
    end
    results{i}=Y;
    tVecs{i} = t;

end

figure;
[t,y] = ode45(@(t,y) los(t,y,R,L,C), tspan, y0);

% Plot for N = 40
subplot(5, 1, 1);
plot(tVecs{1}, results{1}(1,:), 'LineWidth', 1.5, 'DisplayName', 'N=40');
hold on;
plot(t, y(:,1), 'r--', 'LineWidth', 1.5, 'DisplayName', 'N=ODE');
xlabel('Time (s)');
ylabel('q(t)');
title('q(t) for N = 40');
grid on;

% Plot for N = 80
subplot(5, 1, 2);
plot(tVecs{2}, results{2}(1,:), 'LineWidth', 1.5, 'DisplayName', 'N=80');
hold on;
plot(t, y(:,1), 'r--', 'LineWidth', 1.5, 'DisplayName', 'N=ODE');
xlabel('Time (s)');
ylabel('q(t)');
title('q(t) for N = 80');
grid on;

% Plot for N = 160
subplot(5, 1, 3);
plot(tVecs{3}, results{3}(1,:), 'LineWidth', 1.5, 'DisplayName', 'N=160');
hold on;
plot(t, y(:,1), 'r--', 'LineWidth', 1.5, 'DisplayName', 'N=ODE');
xlabel('Time (s)');
ylabel('q(t)');
title('q(t) for N = 160');
grid on;

% Plot for N = 320
subplot(5, 1, 4);
plot(tVecs{4}, results{4}(1,:), 'LineWidth', 1.5, 'DisplayName', 'N=320');
hold on;
plot(t, y(:,1), 'r--', 'LineWidth', 1.5, 'DisplayName', 'N=ODE');
xlabel('Time (s)');
ylabel('q(t)');
title('q(t) for N = 320');
grid on;

subplot(5, 1, 5);
plot(t, y(:,1), 'r--', 'LineWidth', 1.5, 'DisplayName', 'N=ODE');
xlabel('Time (s)');
ylabel('q(t)');
title('q(t) ODE45');
grid on;

% Den numeriska llösningen är mest stabil för höga värden på N, när N = 320
% är den mest stabil
% den numeriska lösningen är mest instabil för N = 80
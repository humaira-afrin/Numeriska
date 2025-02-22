% diff ekvationen
f = @(t,y) sin(3*t) - 2*y;
% exakta lösningen
[T, Y] = ode45(f, [0,8], 1.2);

% Analytiska lösningen
g = @(t) (93/65)*exp(-2*t) - (3/13)*cos(3*t) + (2/13)*sin(3*t);
t_vals = linspace(0,8,100);
y_exact = g(t_vals);

% Plot
figure;
plot(T, Y, 'bo-', 'DisplayName', 'Numerical (ode45)'); % Blue circles for numerical solution
hold on;
plot(t_vals, y_exact, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Analytical Solution'); % Red line for exact solution
hold off;

xlabel('t');
ylabel('y(t)');
legend;
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% b
n = [50;100;200;400];
T = 8;
y0= 1.2;

tVecs = cell(length(n), 1);  % Store time vectors
yVecs = cell(length(n), 1);  % Store solution vectors
% Eulers metod
for i=1:4
    h = T/n(i);
    t = 0;
    y=y0;
    tvec = zeros(n(i) + 1, 1);  
    yvec = zeros(n(i) + 1, 1); 
    tvec (1) = t ; 
    yvec (1) = y ;

    for ii =1: n(i)
        y = y + h * f ( t,y ) ;
        t = t + h ;
        tvec ( ii +1) = t ;
        yvec ( ii +1) = y ;
        
    end
    yVecs{i} = yvec;
    tVecs{i} = tvec;
end


figure;
hold on;
plot(tVecs{1}, yVecs{1}, 'bo-', 'DisplayName', 'n=50');
plot(tVecs{2}, yVecs{2}, 'r-', 'DisplayName', 'n=100');
plot(tVecs{3}, yVecs{3}, 'g-', 'DisplayName', 'n=200');
plot(tVecs{4}, yVecs{4}, 'm-', 'DisplayName', 'n=400');
plot(t_vals, y_exact, 'r-', 'LineWidth', 1.5, 'DisplayName', 'Analytiska lösningen'); % Red line for exact solution
legend;
hold off;
xlabel('t');
ylabel('y(t)');
grid on;

error50 = abs(g(tVecs{1})-yVecs{1});
error100 = abs(g(tVecs{2})-yVecs{2});
error200 = abs(g(tVecs{3})-yVecs{3});
error400 = abs(g(tVecs{4})-yVecs{4});

figure;
hold on;
plot(tVecs{1}, error50, 'r-', 'DisplayName', 'n=50');
plot(tVecs{2}, error100, 'b-', 'DisplayName', 'n=100');
plot(tVecs{3}, error200, 'm-', 'DisplayName', 'n=200');
plot(tVecs{4}, error400, 'g-', 'DisplayName', 'n=400');
legend;
title('Error framåt')
xlabel('t');
ylabel('Error');
grid on;
hold off;

%yVecs{1}(end)
%g(8)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%c
e1 = abs(g(8)-yVecs{1}(end))
e2 = abs(g(8)-yVecs{2}(end))
e3 = abs(g(8)-yVecs{3}(end))
e4 = abs(g(8)-yVecs{4}(end))

%d
% Eulers metod
for i=1:4
    h = T/n(i);
    t = 0;
    y=y0;
    t_vec = zeros(n(i) + 1, 1);  
    y_vec = zeros(n(i) + 1, 1); 
    t_vec (1) = t ; 
    y_vec (1) = y ;

   for ii =1: n(i)
        t_vec(ii+1) = t_vec(ii) + h ; % RÄKNA t i +1 först
        y = (y_vec(ii) + h * sin(3 * t_vec(ii + 1))) / (1 + 2 * h);
        y_vec ( ii +1) = y ;
    end
    y_Vecs{i} = y_vec;
    t_Vecs{i} = t_vec;
end

error_50 = abs(g(t_Vecs{1})-y_Vecs{1});
error_100 = abs(g(t_Vecs{2})-y_Vecs{2});
error_200 = abs(g(t_Vecs{3})-y_Vecs{3});
error_400 = abs(g(t_Vecs{4})-y_Vecs{4});
figure;
hold on;
plot(t_Vecs{1}, error_50, 'r-', 'DisplayName', 'n=50');
plot(t_Vecs{2}, error_100, 'b-', 'DisplayName', 'n=100');
plot(t_Vecs{3}, error_200, 'm-', 'DisplayName', 'n=200');
plot(t_Vecs{4}, error_400, 'g-', 'DisplayName', 'n=400');
legend;
title('Error bakåt')
xlabel('t');
ylabel('Error');
grid on;
hold off;

e_1 = abs(g(8)-y_Vecs{1}(end))
e_2 = abs(g(8)-y_Vecs{2}(end))
e_3 = abs(g(8)-y_Vecs{3}(end))
e_4 = abs(g(8)-y_Vecs{4}(end))

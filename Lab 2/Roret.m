clear all

function [A,b,ri,N,T,TN1] = diskretisering_temperatur(N,alfa,k,r0,rN1,Te,T0)
    tol = 0.1;
    TN1_old = Te; % Initial guess
    err = 1;

    while err > tol
        h = 1/(N+1);    % Steglängd 
        ri = [r0+h:h:rN1-h]';   %Inre punkter (r1, r2, r3, r4 ...) 
    
        A = zeros(N,N);     % Sätter upp matris A
        A(1,1:2) = [(-2*ri(1))/(h^2)  ri(1)/(h^2)+1/(2*h)];   % Första raden

        for i = 2:N-1
            A(i,i-1) = ri(i)/(h^2) - 1/(2*h);   % T_(i-1)
            A(i,i) = (-2*ri(i))/(h^2);            % T_(i)
            A(i,i+1) = ri(i)/(h^2) + 1/(2*h);   % T_(i+1)
        end

        A(N,N-1:N) = [ri(N)/(h^2)-1/(2*h)  (-2*ri(N))/(h^2)+(k*ri(N))/(k*(h^2)+alfa*h^3)+k/(k*2*h+2*alfa*h^2)]; % Sista raden
        A = sparse(A); % Spara den som gles matris

        b = zeros(N,1); % Sätter upp matris b

        b(1) = T0/(2*h) - (T0*ri(1))/(h^2);
        b(N) = -((Te*alfa*h)/(k+alfa*h))*(ri(N)/(h^2)+1/(2*h));

        T = A\b;

        TN1 = (Te*alfa*h + T(N)*k) / (k + alfa*h);
        err = abs(TN1-TN1_old);
        TN1_old = TN1;
        N = 2 * N;
    end
    
    
end

N = 25;              % Delintervall
alfa = 1;
k = 1; 
Te = 20;
r0 = 1; rN1 = 2;     % Randpunkter
T0 = 450;       % Första randvärde


[A,b,ri,N,T,TN1] = diskretisering_temperatur(N,alfa,k,r0,rN1,Te,T0);

TN1
%plot([1;ri;N],[T0;T;T(end)] ,'--o ')   wrong

clear all

function T = trapets(beta) % Trapetsmetoden
    a = 0;
    b = 20;
    h = 1/64;
    x = a:h:b;
    y = (exp(beta .* x) + 8) ./ (1 + (x ./ 5) .^ 3); % Definierar y(x;beta)
    Th =  h * (sum(y.^2) - 0.5 * (y(1)^2 + y(end)^2)); % Räknar ut integrationen av y(x;beta)^2 med trapetsmetoden
    T = pi * Th - 1500; % Räknar ut hela F(beta)
end

beta0 = 0.1; % Första gissning
beta1 = 0.3; % Andra gissning
tol = 1e-8; % Tolerans 10^-8
err = abs(beta1-beta0); % Skillnad mellan beta1 och beta0
iter = 0;

F0 = trapets(beta0); % Räknar ut vad F blir när beta = 0.1 med trapetsmetoden
F1 = trapets(beta1); % Räknar ut vad F blir när beta = 0.3 med trapetsmetoden
while (err > tol) % Loppar så länge skillnaden mellan första och andra gissning (err) är större än toleransen
        beta2 = beta1 - ((F1*(beta1-beta0)) / (F1-F0)); % Använder sekantmetoden för att hitta nytt värde nära nollstället
        err = abs(beta2 - beta1); % Skillnaden mellan nya värdet och beta1
        beta0 = beta1; 
        F0 = F1;
        beta1 = beta2;
        F1 = trapets(beta1); % Räknar ut vad F blir med nytt beta värde
        
        fprintf('Iteration: %2d  Beta: %.6f  F(beta): %.6f\n', iter, beta1, F1);
        iter = iter + 1;
end

fprintf('Beta (the root) is %.8f',beta1);

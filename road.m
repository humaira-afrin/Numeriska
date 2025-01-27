% Här fyller du i ekvationerna i systemet
%     xA, yA 
A = [175, 950;
     410, 2400;
     675, 1730]

%    xB , yB
B = [160, 1008;
      381, 2500 ;
      656, 1760]

%     LA , LB
L = [ 60 , 46;
      75 , 88;
      42 , 57]



f = @(x1,y1,x2,y2,x3,y2) [
    (x1 - A(1,1))^2 + (y1 - A(1,2))^2 + 0 + 0 + 0 + 0 - (L(1,1)^2);
    (x1 - B(1,1))^2 + (y1 - B(1,2))^2 + 0 + 0 + 0 + 0 - (L(1,2)^2);
    0 + 0 + (x2 - A(2,1))^2 + (y2 - A(2,2))^2 + 0 + 0 - (L(2,1)^2);
    0 + 0 + (x2 - B(2,1))^2 + (y2 - B(2,2))^2 + 0 + 0 - (L(2,2)^2);
    (x3 - A(3,1))^2 + (y3 - A(3,2))^2 + 0 + 0 + 0 + 0 - (L(3,1)^2);
    0 + 0 + 0 + 0 + (x3 - B(3,1))^2 + (y3 - B(3,2))^2 - (L(3,2)^2);

   
];
 %{
% Här fyller du i komponenterna i Jacobianen
J = @(x, y, z) [
    2*(x - x1o), 2*(y - y1o), 2*(z - z1o);
    2*(x - x2o), 2*(y - y2o), 2*(z - z2o);
    2*(x - x3o), 2*(y - y3o), 2*(z - z3o)
];

% Kontrollerar att ekvationerna och Jacobianen är korrekt
fkoll=f(10,10,10);
Jkoll=J(10,10,10);


xstart=[3, -3];  % fyll i startgissning för x (ett värde för varje skärningspunkt)
ystart=[0, 2];  % fyll i startgissning för y (ett värde för varje skärningspunkt)
zstart=[1, -1];  % fyll i startgissning för z (ett värde för varje skärningspunkt)

tol=1e-11;
for i=1:2   % loopa över de två skärningspunkterna
    x=xstart(i);
    y=ystart(i);
    z=zstart(i);
    
    % Här ska Newtons metod implementeras
    hnorm = 1; iter = 0;
    while hnorm > tol && iter < 20
        iter = iter + 1;
        h = -J ( x,y,z ) \ f ( x,y,z ) ; % Los linjara ekvsystemet
        x = x + h(1) ; y= y+h(2) ; z=z+h(3); % Uppdatera
        hnorm = norm ( h ) ;
        disp ([ iter x y z hnorm ])
    end



    % När Newton är klar, lagra resultatet i radvektorerna 
    % xrot, yrot, zrot (ett värde för varje skärningspunkt)
    xrot(i) = x;
    yrot(i) =y;
    zrot(i) = z;
end

rot1 = [xrot(1), yrot(1), zrot(1)];
rot2 = [xrot(2), yrot(2), zrot(2)];
disp("Intersection points:");
disp(rot1);
disp(rot2); 
%}


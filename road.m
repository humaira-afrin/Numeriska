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



f = @(x1,y1,x2,y2,x3,y3) [
    (x1 - A(1,1))^2 + (y1 - A(1,2))^2 + 0 + 0 + 0 + 0 - (L(1,1)^2);
    (x1 - B(1,1))^2 + (y1 - B(1,2))^2 + 0 + 0 + 0 + 0 - (L(1,2)^2);
    0 + 0 + (x2 - A(2,1))^2 + (y2 - A(2,2))^2 + 0 + 0 - (L(2,1)^2);
    0 + 0 + (x2 - B(2,1))^2 + (y2 - B(2,2))^2 + 0 + 0 - (L(2,2)^2);
    0 + 0 + 0 + 0 + (x3 - A(3,1))^2 + (y3 - A(3,2))^2 - (L(3,1)^2);
    0 + 0 + 0 + 0 + (x3 - B(3,1))^2 + (y3 - B(3,2))^2 - (L(3,2)^2);

   
];


% Här fyller du i komponenterna i Jacobianen
J = @(x1,y1,x2,y2,x3,y3) [
    2* (x1 - A(1,1)), 2*(y1 - A(1,2)), 0, 0, 0, 0;
    2*(x1 - B(1,1)), 2*(y1 - B(1,2)), 0, 0, 0, 0;
    0, 0, 2*(x2 - A(2,1)), 2*(y2 - A(2,2)), 0, 0;
    0, 0, 2*(x2 - B(2,1)), 2*(y2 - B(2,2)), 0, 0;
    0, 0, 0, 0, 2*(x3 - A(3,1)), 2*(y3 - A(3,2));
    0, 0, 0, 0, 2*(x3 - B(3,1)), 2*(y3 - B(3,2));
];

% Startgissning
x1start=[200, 300];  
y1start=[1000, 1500];
x2start=[400,500];  
y2start=[0, 2];  
x3start=[3, -3];  
y3start=[0, 2];  


tol=1e-11;
for i=1:2   % loopa över de två skärningspunkterna
    x1=x1start(i);
    y1=y1start(i);
    x2=x2start(i);
    y2=y2start(i);
    x3=x3start(i);
    y3=y3start(i);
   
    
    % Här Newtons metod implementeras
    hnorm = 1; iter = 0;
    while hnorm > tol && iter < 20
        iter = iter + 1;
        h = -J ( x1,y1,x2,y2,x3,y3 ) \ f ( x1,y1,x2,y2,x3,y3 ) ; % Los linjara ekvsystemet
       % Uppdatera
        x1 = x1 + h(1) ; y1= y1+h(2) ; 
        x2=x2+h(3); y2 = y2+h(4);
        x3 = x3 + h(5); y3 = y3 + h(6);

        hnorm = norm ( h ) ;
        disp ([ iter x1 y1 x2 y2 x3 y3 hnorm ])
    end



    % När Newton är klar, lagra resultatet i radvektorerna 
    % xrot, yrot, zrot (ett värde för varje skärningspunkt)
    x1rot(i) = x1;
    y1rot(i) =y1;
    x2rot(i) = x2;
    y2rot(i) =y2;
    x3rot(i) = x3;
    y3rot(i) =y3;
end

rotP11 = [x1rot(1), y1rot(1)];
rotP12 = [x1rot(2), y1rot(2)];

rotP21 = [x2rot(1), y2rot(1)];
rotP22 = [x2rot(2), y2rot(2)];

rotP31 = [x3rot(1), y3rot(1)];
rotP32 = [x3rot(2), y3rot(2)];

disp("Intersection points:");
disp(rotP11);
disp(rotP12); 
disp(rotP21);
disp(rotP22); 
disp(rotP31);
disp(rotP32); 



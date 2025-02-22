%Uppgidt 3a

% vektor av alla xA och yA värdena för P1,P2 och P3
%     xA, yA 
A = [175, 950;
     410, 2400;
     675, 1730];

xA=[175, 410, 675]';
yA=[950,2400,1730]';

% vektor av alla xB och yB värdena för P1,P2 och P3
%    xB , yB
B = [160, 1008;
      381, 2500 ;
      656, 1760];

xB=[160,381,656];
yB=[1008, 2500, 1760];

% vektor av alla avstånd mellan xA, xB värdena och P1,P2 och P3
%     LA , LB
L = [ 60 , 45;
      75 , 88;
      42 , 57];

LA=[60, 75, 42];
LB=[45, 88, 57];

%funtionen: 2 ekvationssystem för en Punkt. 6 okända. 
% (x-xA)^2 +(y-yA)^2=LA^2
% (x-xB)^2 +(y-yB)^2=LB^2
% x och y värdena är okända som vi ska hitta och xA,xB samt yA,yB värden
% tas från vektor A och B


g = @(x,y) [
    (x-xA).^2 + (y-yA).^2 - LA.^2;
    (x-xB).^2 + (y-yB).^2 - LB.^2;
    
    ]
Jg = @(x,y) [
    2* (x - xA), 2*(y - yA);
    2* (x - xB), 2*(y - yB);

    ]


f = @(x1,y1,x2,y2,x3,y3) [
    (x1 - A(1,1))^2 + (y1 - A(1,2))^2 + 0 + 0 + 0 + 0 - (L(1,1)^2);
    (x1 - B(1,1))^2 + (y1 - B(1,2))^2 + 0 + 0 + 0 + 0 - (L(1,2)^2);
    0 + 0 + (x2 - A(2,1))^2 + (y2 - A(2,2))^2 + 0 + 0 - (L(2,1)^2);
    0 + 0 + (x2 - B(2,1))^2 + (y2 - B(2,2))^2 + 0 + 0 - (L(2,2)^2);
    0 + 0 + 0 + 0 + (x3 - A(3,1))^2 + (y3 - A(3,2))^2 - (L(3,1)^2);
    0 + 0 + 0 + 0 + (x3 - B(3,1))^2 + (y3 - B(3,2))^2 - (L(3,2)^2);

   
];




% komponenterna i Jacobianen: derivatan
J = @(x1,y1,x2,y2,x3,y3) [
    2* (x1 - A(1,1)), 2*(y1 - A(1,2)), 0, 0, 0, 0;
    2*(x1 - B(1,1)), 2*(y1 - B(1,2)), 0, 0, 0, 0;
    0, 0, 2*(x2 - A(2,1)), 2*(y2 - A(2,2)), 0, 0;
    0, 0, 2*(x2 - B(2,1)), 2*(y2 - B(2,2)), 0, 0;
    0, 0, 0, 0, 2*(x3 - A(3,1)), 2*(y3 - A(3,2));
    0, 0, 0, 0, 2*(x3 - B(3,1)), 2*(y3 - B(3,2));
];

% Startgissning, 2 gissning per elemnt för att cirkeln skärs i två punkter
%{
x1start=[205, 123];  
y1start=[1001, 980];
x2start=[458,338];  
y2start=[2457, 2422];  
x3start=[713, 653];  
y3start=[713, 1757];  
%}
x1start=[200, 100];  
y1start=[1000, 980];
x2start=[460,350];  
y2start=[2500, 2400];  
x3start=[700, 650];  
y3start=[700, 1800];  


%toleransen
tol=1e-11;

% Cirkeln skärs i två punkter --> loopa över de två skärningspunkterna
for i=1:2   
    x1=x1start(i);
    y1=y1start(i);
    x2=x2start(i);
    y2=y2start(i);
    x3=x3start(i);
    y3=y3start(i);
   
    
    % Här Newtons metod implementeras
    hnorm = 1; iter = 0; diffx=[];
    while hnorm > tol && iter < 20
        iter = iter + 1;
        h = -J ( x1,y1,x2,y2,x3,y3 ) \ f ( x1,y1,x2,y2,x3,y3 ) ; % Los linjara ekvsystemet
       % Uppdatera enligt xn+1=h+xn
        x1 = x1 + h(1) ; y1= y1+h(2) ; 
        x2=x2+h(3); y2 = y2+h(4);
        x3 = x3 + h(5); y3 = y3 + h(6);
        % normen av alla punkt element
        hnorm = norm ( h ) ;
        % spara normen i en vektor för att plotta
        diffx=[diffx,norm(h)];
        %disp ([ iter x1 y1 x2 y2 x3 y3 hnorm ])
    end



    % När Newton är klar, lagra resultatet i radvektorerna 
    % x1rot, y1rot... (ett värde för varje skärningspunkt)
    x1rot(i) = x1;
    y1rot(i) =y1;
    x2rot(i) = x2;
    y2rot(i) =y2;
    x3rot(i) = x3;
    y3rot(i) =y3;
end

% Punkt P1
rotP11 = [x1rot(1), y1rot(1)]; % första skärningspunkt
rotP12 = [x1rot(2), y1rot(2)]; % andra skärningspunkt
% Punkt P2
rotP21 = [x2rot(1), y2rot(1)]; % första skärningspunkt
rotP22 = [x2rot(2), y2rot(2)]; % andra skärningspunkt
% Punkt P3
rotP31 = [x3rot(1), y3rot(1)]; % första skärningspunkt
rotP32 = [x3rot(2), y3rot(2)]; % andra skärningspunkt

disp("Intersection points: both roots for P1, P2 and P3");
disp("P1 root 1");
disp(rotP11);
disp("P1 root 2");
disp(rotP12);
disp("P2 root 1");
disp(rotP21);
disp("P2 root 2");
disp(rotP22); 
disp("P3 root 1");
disp(rotP31);
disp("P3 root 2");
disp(rotP32); 


% Konvergenshastighet
figure;
semilogy(1:length(diffx), diffx,'LineWidth',1);
xlabel('iterationer')
ylabel('Normen')

%______________-----------------___________________--------------------____________________------------------
% Uppgift 3b

%Ansats: P = c0+c1x+c2x^2+c3x^3+c4^x^4
% Ac=b
P0=[0;0];
P4=[1020;0];
rot_y = [P0(2), rotP11(2), rotP21(2), rotP32(2), P4(2)]';
rot_x = [P0(1), rotP11(1), rotP21(1), rotP32(1), P4(1)]';
d = length(rot_y);


A1 = [ones(d, 1), rot_x, rot_x.^2, rot_x.^3, rot_x.^4];
%{
A=[ones(1,5); % konstanta termen 
    P0(1),rotP11(1), rotP21(1),rotP31(1),P4(1); % linjärna termen x
    P0(1),(rotP11(1)^2), (rotP21(1)^2),(rotP31(1)^2),(P4(1)^2); % kvadratiska termen x^2
    P0(1),rotP11(1)^3, rotP21(1)^3,rotP31(1)^3,P4(1)^3; % x^3
    P0(1),rotP11(1)^4, rotP21(1)^4,rotP31(1)^4,P4(1)^4; % x^4
    ]'
%}

c=A1\rot_y

p = @(x) c(1) + c(2).*x + c(3).*x.^2 + c(4).*x.^3 + c(5).*x.^4;

figure;
grid on;
fplot(p,[0,1020],'LineWidth',1);
hold on;
plot(rot_x,rot_y,'o','LineWidth',2)
xlabel('x-koordinater')
ylabel('ykoordinater')

fprintf("%.10f\n",c(5))


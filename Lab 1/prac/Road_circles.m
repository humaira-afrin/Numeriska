center1_x = 675; % x-coordinate of the center
center1_y = 1739; % y-coordinate of the center
radius1 = 42; % radius of the circle

center2_x = 656; % x-coordinate of the center
center2_y = 1760; % y-coordinate of the center
radius2 = 57; % radius of the circle

% Define the angle range for the circles
theta = linspace(0, 2*pi, 100); % 100 points from 0 to 2π

% Parametric equations for the first circle
x1 = center1_x + radius1 * cos(theta);
y1 = center1_y + radius1 * sin(theta);

% Parametric equations for the second circle
x2 = center2_x + radius2 * cos(theta);
y2 = center2_y + radius2 * sin(theta);

% Plot the first circle
figure;
plot(x1, y1, 'b-', 'LineWidth', 1.5); 
hold on;

% Plot the second circle
plot(x2, y2, 'g-', 'LineWidth', 1.5);


% Add labels, title, and grid
xlabel('x');
ylabel('y');
title('Two Circles on the Same Figure');
axis equal; % Equal scaling for x and y
grid on;

legend('Circle 1', 'Circle 2');

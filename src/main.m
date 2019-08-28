clear,clc,close all
tic

% % % Choose the img you wanna use % % % % 
% img_name = '../imgs/llave.png';
img_name = '../imgs/triangulo.png';
% img_name = '../imgs/estrella.png';
% focus_of_light = [12.5, 12.5];
% itMax = 150;
% 
img_name = '../imgs/u.png';
focus_of_light = [-30, 15];
itMax = 400;


% % % % % Read the image % % % %
img_read = uint16(imread(img_name));
img.shape = round(img_read(:,:,3)/255);
img.antiphoto = round(img_read(:,:,2)/255);
img.photo = round(img_read(:,:,1)/255);


% % % % % Start the robots parameters % % %
n_robots = 725;               % number of robots

rob_known =[364,388,389];     % robots who play as seeds

robot_empty.id = [];          % id of each robot
robot_empty.r = 1/2;          % radius of each robot
robot_empty.state = 1;
% % 1 Unlocalized
% % 2 From Shape
% % 3 Phototaxis
% % 4 Antiphototaxis
robot_empty.pos = [];         % Real Position
robot_empty.pos_guessed = []; % Position guessed by the robot
robot_empty.in_phase3 = 0; % the robot is deconstructing yet? 
robot_empty.ready = [];     % Is ready to deconstruct?
robot_empty.focus_of_light = [];  % Where the focus of light is?

robot_empty.img = [];  % img of the figure
robot_empty.signal_length = 3.01 * sqrt(3)/2; %length of the wireless signal



robots=repmat(robot_empty,n_robots,1);  % Create all the robots

% % % % % Give the positions to the robots % % % %
N = floor(sqrt(n_robots)+3);
M = floor(n_robots/N);
rob=0;
for i = 1 : N
    for j=1:M
        rob = rob + 1;
        robots(rob).id = rob;
        robots(rob).pos(2) = sqrt(3)/2*(i);
        robots(rob).focus_of_light = focus_of_light;
        if mod(i,2)==1
            robots(rob).pos(1) = (j);
        else
            robots(rob).pos(1) = (j+(1/2));
        end
    end
end

% % % % % Give the img and the position to the seeds
for i = 1 : length(rob_known)
    robots(rob_known(i)).pos_guessed = robots(rob_known(i)).pos;
    robots(rob_known(i)).img = img;
    robots = give_states( robots,rob_known(i));
end

% % % % % This is only for proofs
% % % % % It gives all the robots their position
for i=1:rob
    robots(i).pos_guessed = robots(i).pos;
    robots(i).img = img;   
    robots = give_states( robots,i);
end
% % % % Except for 10 of them, randomly chosen
for i=1:2%10
    I = randi(rob);
    robots(I).pos_guessed = [];
    robots(I).img = [];   
    robots(I).state = 1;
end

plot_robots_color(robots) % show the state of the robots


for it = 1:itMax
    IT = it
    % % % %  Each robot do their action
    for i=1:rob
        robots = robot_action( robots, i ); 
    end
    
    % % % % Plot the robots
    if robots(rob).in_phase3 == 0
        plot_robots_color(robots)
    else
        plot_robots(robots)
    end
    
    
end

toc



function [ robots ] = phase1( robots, i )
syms x y positive
syms a1 a2 a3 real


rob_seen.id =[];
rob_seen.dist =[];
rob = length(robots);
% Tell me which robots I see, are not unlocalized and get their id and dist
% to me
for j = 1:rob
    if i~=j
        if robots(j).state ~= 1 && norm(robots(j).pos - robots(i).pos) < robots(j).signal_length
            if isempty(robots(i).img) == 1
                robots(i).img = robots(j).img;
            end
            rob_seen.id = [rob_seen.id, robots(j).id];
            rob_seen.dist = [rob_seen.dist, sqrt((robots(j).pos(1) - robots(i).pos(1)).^2 + (robots(j).pos(2) - robots(i).pos(2)).^2)];
        end
    end
end


if length(rob_seen.id) > 2
    % Choose 3 robots anda compute my position
    for elec = 1:3
        r = randi(length(rob_seen.id));
        rob_e.id(elec) = rob_seen.id(r);
        rob_e.dist(elec) = rob_seen.dist(r);
        rob_seen.id(r) = [];
        rob_seen.dist(r) = [];
    end
    
    eqn = [x == rob_e.dist(1)*sin(a1) + robots(rob_e.id(1)).pos_guessed(1),   ...
        x == rob_e.dist(2)*sin(a2) + robots(rob_e.id(2)).pos_guessed(1),  ...
        x == rob_e.dist(3)*sin(a3) + robots(rob_e.id(3)).pos_guessed(1),  ...
        y == rob_e.dist(1)*cos(a1) + robots(rob_e.id(1)).pos_guessed(2),  ...
        y == rob_e.dist(2)*cos(a2) + robots(rob_e.id(2)).pos_guessed(2)];
    
    S = solve(eqn);
    try
        robots(i).pos_guessed(1) = S.x(randi(length(S.x)));
        robots(i).pos_guessed(2) = S.y(randi(length(S.y)));
        
    end
end

% If i get a position, tell me my state
robots = give_states( robots,i);



end


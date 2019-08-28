function [ robots ] = give_states( robots,rob)


if isempty(robots(rob).pos_guessed)==0 && norm(robots(rob).pos - robots(rob).pos_guessed)<1
    
    [M,N] = size(robots(rob).img.shape);
    robots(rob).pos_guessed = robots(rob).pos;
    n_rob = length(robots);
    
    
    pos =[];
    for i = 1:n_rob
        pos = [pos; robots(i).pos];
    end
    pos_max = max(pos);
    pos_min = min(pos);
    
    
    rel_pos = round((robots(rob).pos-pos_min)./(pos_max-pos_min).*[M-1,N-1]+[1,1]);
    
    if robots(rob).img.shape(rel_pos(1),rel_pos(2),1) == 1
        robots(rob).state = 2;
    elseif robots(rob).img.photo(rel_pos(1),rel_pos(2),1) == 1
        robots(rob).state = 3;
    elseif robots(rob).img.antiphoto(rel_pos(1),rel_pos(2),1) == 1
        robots(rob).state = 4;
    end
end
end


function [ robots ] = phase2( robots, i )

r_seen.id = [];
rob = length(robots);
% % Tell me which robots I see
for j = 1:rob
    if i~=j
        if norm(robots(j).pos - robots(i).pos) < robots(j).signal_length
            r_seen.id = [r_seen.id, j];
        end
    end
end
N = length ( r_seen.id);
% % % If my neighborhood is localized, aux = 1.
aux = 1;
for j = 1:N
    if robots(r_seen.id(j)).state == 1
        aux = 0;
    end
end
% % % If aux == 1, get my id in the vector of robots ready for phase3 and
% % % compare vectors with neighbors. If all are ready, phase3
if aux == 1
    robots(i).ready = unique([robots(i).ready robots(i).id]);
    for j = 1:N
        robots(i).ready = unique([robots(i).ready robots(r_seen.id(j)).ready]);
    end
    for j = 1:N
        robots(i).ready = unique([robots(i).ready robots(r_seen.id(j)).ready]);
    end
    if length(robots(i).ready) == rob
        robots(i).in_phase3 = 1;
    end
end

end


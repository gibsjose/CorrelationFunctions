function [X] = randomPulse(L, P)
%Usage: [X] = randomPulse(L, P)
%where X is a random pulse vector made up of
%L pulses of pulse length P

%Create X vector
X = zeros((L * P), 1);

%Populate X vector
for i = 1:P:(L * P)
    if(rand() <= 0.5)
        for j = i:(i + P)
            X(j) = -1;
        end
    else
        for k = i:(i + P)
            X(k) = 1;
        end
    end
end


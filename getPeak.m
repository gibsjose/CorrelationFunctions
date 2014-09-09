function [peakTime] = getPeak(C)
%Usage: [peak] = getPeak(C)
%where peak is the x value of when the peak in C occurrs

peakTime = 0;

for i = 1:(length(C) - 1)
    peak = C(i);
    peakTime = i;
    
    if(C(i + 1) > peak)
        peakTime = i + 1;
    end
end


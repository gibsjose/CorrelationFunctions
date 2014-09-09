% Joe Gibson
% EGR 280 - Lab 12
% Applications of Correlation Functions

%Clear the command window and previous variables
clear;
clc;

%Seed the random number generator
SEED = sum(100*clock);
rand('seed', SEED);

% PART 1 %
%%%%%%%%%%
%Determine a quasi random pulse for X
%of 1000 pulses of pulse width 10
X = randomPulse(1000, 10);

%Simulate the round trip transmission by adding noise and a delay
alpha = .01;
delta = 1000;
Y = [zeros((2 * delta), 1); alpha*X];

%Add noise with SNR 20db
SNR = -10;
varX = var(X);
sigmaN = sqrt(varX / (10 ^ (SNR/10)));
N = sigmaN * randn(length(Y), 1);
Y = Y + N;

%Compute the cross-correlation
Ryx = xcorr(Y, X);

%Determine the peak in the cross-correlation
L = length(Ryx);
H = ceil(L / 2) + 1;
[peak, peakTime] = max(Ryx(H:L));

%Detemine X axes
AX = 0:length(X) - 1;
AY = 0:length(Y) - 1;
AR = 0:H - 3;

%Plots:
figure(1);
plot(AX, X);
grid on;
xlabel('t');
ylabel('X(t)');
title('X(t) vs t');

figure(2);
plot(AY, Y);
grid on;
xlabel('t');
ylabel('Y(t)');
title('Y(t) vs t using SNR = 20dB, alpha = 0.01, delta = 1000');

figure(3);
plot(AR, Ryx(H:L));
grid on;
xlabel('t');
ylabel('Ryx');
title('Ryx vs t using SNR = 20dB, alpha = 0.01, delta = 1000');

% PART 2 %
%%%%%%%%%%
%Define number of samples
numSamples = 2000;

%Define the random phase vector
Theta = randn(numSamples + 1, 1);

%Define the delta t
dT = 0.1;

%Define t vector
t = 0:dT:(dT * numSamples);
t = t';

%Define frequency to be 1 Hz
f = 1 / (100 * dT);

%Define omega
w = 2 * 3.14 * f;

%Define transmission as a function of t
Yp = cos((w * t) + Theta);

%Determine SNR, create, scale, and add noise
SNR = 20;
varTheta = var(Theta);
sigmaN = sqrt(varTheta / (10 ^ (SNR/10)));
N = sigmaN * randn(length(Yp), 1);
Yp = Yp + N;

%Compute the autocorrelation
Ryy = xcorr(Yp);

%Determine the peak in the autocorrelation
L = length(Ryy);
H = ceil(L / 2) + 1;
[pPeak, pPeakTime] = max(Ryy(H:L));

%Plots:
figure(4);
plot(t, Yp);
grid on;
xlabel('t');
ylabel('Yp(t)');
title('Yp(t) vs t');

figure(5);
plot(t, Ryy(H-1:L));
grid on;
xlabel('t');
ylabel('Ryy');
title('Ryy vs t using SNR = 20dB');

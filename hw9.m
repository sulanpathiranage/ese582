%% Homework 9
%% Introduction
% * Author:                   Sulan Pathiranage
% * Class:                    ESE 582
% * Date:                     Updated 3/25/24

%% Probability
p0 = 1;
x = linspace(-2, 2, 100);
y = transpose(x);
p = sqrt(x.^2+y.^2);
I = 1/p0 * exp(-p/p0);
figure(1)
imagesc(x,y,I), xlim([-2 2]), ylim([-2,2]), colorbar, title("Probability Distribution in z = 0");
%% Shot Noise
I_max = 3;
lambda = 561e-9;
d= 15e-3;

x_pix = 1920; % pixel numbers of CMOS camera
y_pix = 1200;
pix_size = 5.86e-6; % pixel size of CMOS camera
[X, Y] = meshgrid( linspace(-x_pix*pix_size/2,x_pix*pix_size/2,x_pix), linspace(-y_pix*pix_size/2,y_pix*pix_size/2,y_pix));
x = X(1,:);
y = Y(:,1);


w1 = 3e-6;
w2 = 3.1e-6;
I1 = 0.5*I_max*(1+cos(2*pi*X*(w1/(lambda*d))));
I2 = 0.5*I_max*(1+cos(2*pi*X*(w2/(lambda*d))));

%noise
param = 3;
shotnoisei1 = poissrnd(param, size(I1));
shotnoisei2 = poissrnd(param, size(I2));

I1_noisy = poissrnd(I1);
I2_noisy = poissrnd(I2);
%I1_noisyd = I1 + shotnoisei1;
%I2_noisyd = I2+shotnoisei2;

%fit
interferenceEqn = '1/2 * a * (1 + cos(2*pi*x*b/(561E-9*15E-3) + c)) + d';
initGuess1 = [max(I1_noisy(:))-min(I1_noisy(:)) 2.5e-6 0 min(I1_noisy(:))];
initGuess2 = [max(I2_noisy(:))-min(I2_noisy(:)) 2.5e-6 0 min(I2_noisy(:))];
f1 = fit(X(:),I1_noisy(:),interferenceEqn,'Start',initGuess1);
f2 = fit(X(:),I2_noisy(:),interferenceEqn,'Start',initGuess2);

fh = figure(2);
fh.WindowState = 'maximized';
subplot(2,2,1), imagesc(x, y, I1), title("Intensity \omega = 3.0\mum"), colorbar, xlabel("Distance (m)"), ylabel("Distance (m)");
subplot(2,2,2), imagesc(x,y,I2), title("Intensity \omega = 3.1\mum"), colorbar, xlabel("Distance (m)"), ylabel("Distance (m)");
subplot(2,2,3), imagesc(x, y, I1_noisy), title("Noisy Intensity \omega = 3.0\mum"), colorbar, xlabel("Distance (m)"), ylabel("Distance (m)");
subplot(2,2,4), imagesc(x,y,I2_noisy), title("Noisy Intensity \omega = 3.1\mum"), colorbar, xlabel("Distance (m)"), ylabel("Distance (m)");
disp("Fit of w = 3e-6 m:")
disp(f1);
disp("Fit of w = 3.1e-6 m")
disp(f2);

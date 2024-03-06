%% In the name of God

%% Moving average test

clc
clear
close all,

load('mhb_Data_1.mat')
% Data1 = randn(1,10000);
Data1 = numericArray(1:1000);
Data1 = Data1 - mean(Data1);

Fs    = 10000; 
N     = 21; 
Fpass = 10;
Fstop = 200;
Wpass = 1;  
Wstop = 1;  
dens  = 20; 
b     = firpm(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop],{dens});
Hd    = dfilt.dffir(b);
h1    = filter(Hd,[1 zeros(1,dens+1)]);
h1    = h1 ./ sum(h1);
Len1  = length(h1);
h2    = ones(1,22) / 22;
h3    = ones(1,10) / 10 .* kaiser(10,3).';
h3    = h3 ./ sum(h3);

y1    = conv(Data1,h1);
y1    = y1(1:end-(Len1-1));
y2    = conv(Data1,h2);
y2    = y2(1:end-(22-1));
y3    = conv(Data1,h3);
y3    = y3(1:end-(10-1));

Data1 = Data1(Len1:end);
y1    = y1(Len1:end);
y2    = y2(Len1:end);
y3    = y3(Len1:end);
% figure, plot(Data1), hold on, plot(y1), hold on, plot(y2), hold on, plot(y3)

figure, subplot(311),p1 = plot(Data1);, hold on, plot(y3)
subplot(312), p2= plot(diff(y2));, hold on, plot(diff(y3))
subplot(313), p3=plot( conv( diff(y2), ones(1,30) ) );, hold on, plot([0,1000],[0,0])
plot( conv( diff(y3), ones(1,30) ) )
linkaxes([p1.Parent, p2.Parent, p3.Parent] , 'x')


% figure,
% subplot(311), plot( db(fftshift(abs(fft(Data1)))) )
% subplot(312), plot( db(fftshift(abs(fft([h1 zeros(1,10000)])))) )
% subplot(313), plot( db(fftshift(abs(fft(y1)))) )
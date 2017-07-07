home
clear
close all
   
%Aufgabe7
dt = 0.001;
T = 2;
a = 5;
T0 = 4;

%Zeilenvektor
t = -10 : dt : 10;
t1 = -20 : dt : 20;

%Signale 
ut = a*(sigma_(t) - sigma_(t-T0));
utT = a*(sigma_(t-T) - sigma_((t-T)-T0));
yt = conv(ut, utT)*dt;

subplot( 3, 1, 1);
plot(t, ut, 'Linewidth',2);
subplot( 3, 1, 2);
plot(t, utT, 'Linewidth',2);
subplot( 3, 1, 3);
plot(t1, yt, 'Linewidth',2);
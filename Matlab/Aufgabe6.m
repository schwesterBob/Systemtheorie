home
clear
close all

%Aufgabe6
dt = 0.001;
T = 2;
a = 5;
T0= 4;
%Zeilenvektor
t = -10 : dt : 10;
%Signale 
ut = a*(sigma_(t) - sigma_(t-T0));
gt = 1/T.*exp(-t/T).*sigma_(t);

%Korrelation durch Faltung
phi = dt * conv(ut, gt);

subplot( 2, 3, 1)
plot(t, ut, 'Linewidth',2);
subplot( 2, 3, 2)
plot(t, gt, 'Linewidth',2);
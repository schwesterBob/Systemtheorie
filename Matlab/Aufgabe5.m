home
clear
close all

%Aufgabe 5
%symmetrischer Zeilenvektor
dt = 0.001;
t = -10 : dt : 10;


%Signale 
s1 = sigma_(t-1)-sigma_(t-3);
s2 = sigma_(t-2)-2*sigma_(t-3)+sigma_(t-4);

%Korrelation durch Faltung
phi = dt * conv(fliplr(s1), s2);

subplot( 2, 3, 1)
plot(t, s1, 'Linewidth',2)
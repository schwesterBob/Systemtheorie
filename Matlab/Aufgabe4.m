home
clear
close all

%Aufgabe 4

%Zeitvektor
dt = 0.001;
t = -10 : dt : 10;
% T = 2 sekunden
T = 2;
% Signal a) S1
S1= sigma_(t).*exp(-t/T);

% Energieberechnung
E = dt*sum(S1.^2);

% Darstellung
subplot( 2, 3, 1)
plot(t, S1, 'Linewidth',2)

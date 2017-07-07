%Aufgabe 15
home
clear
close all

% Polynom als Vektor erzeugen
z_polynom = 10;
n_polynom = [1 0.6 1.05 0.1];

% G(s) erzeugenm mit tf()
sys = tf(z_polynom, n_polynom);

% Zustandsform ssdata() bestimmen
[A, b, c, d] = ssdata(sys);
A
b
c
d
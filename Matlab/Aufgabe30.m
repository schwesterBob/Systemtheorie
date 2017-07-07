%Aufgabe 30

home
clear
close all

T = 1;
td=0:T:20*T;
% G(z) anlegen
s=tf('s');
zaehler = [0.5];
nenner = [1 -1];
Gz=tf(zaehler,nenner,T);


% Eingangssignal berechnen
u= sigma_(td);
y=lsim(Gz, u, td);
stem(td,y);
grid

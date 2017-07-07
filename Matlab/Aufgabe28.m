% Aufgabe 28
home
clear
close all

%G(z) als LTI Objekt
T=0.1;
zaehler = [0.7];
nenner = [1 -0.8 +0.15];
Gz= tf(zaehler, nenner, T);

%Pol-/Nullstellenplan plotten und sprungantwort (step fkt) ausgeben
subplot(2,2,1);
pzmap(Gz);
subplot(2,2,2);
td = 0:T:10*T;
y=step(Gz, td);
stem(td,y);
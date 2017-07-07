%Aufgabe 29
home
clear
close all

T=0.1;
%Kontinurierliches Sys G(s) eingeben
%Gs= 1/(s*(s+1));
s=tf('s');
zaehler = 1;
nenner = s*(s+1);
Gs= 1/nenner;
%Diskretisierung mit c2d(..) durcxhführen (x2) dh 2xc2d mit
%unterschiedlichem string
Gs1= c2d(Gs, T, 'zoh');
Gs2= c2d(Gs, T, 'tustin');

%vgl der Sprungantworten
% dazu analoge und diskrete Zeitachse definieren
t=0:0.01:20*T;
td=0:T:20*T;

y=step(Gs, t);
yd1=step(Gs1, td);
yd2=step(Gs2, td);
%Darstellung mit plot
hold on;
plot(t,y);
stairs(td, yd1);
stem(td, yd2);
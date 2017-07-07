clear % Arbeitsspeicher s‰ubern
home % Cursor in linke obere Bildecke
close all % alle Grafiken schlieﬂen

T = 10;
R = 1e3;
C = T/R;
s = tf('s');

G = 1/ ((1+ s*T)^2);

[A, b, c, d] = linmod('aufgabe22simulink');

Gs = ss(A, b, c, d);

bode(G, Gs);
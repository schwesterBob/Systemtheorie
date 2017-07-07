% Aufgabe 14 
home
clear
close all

% Matrix/Vektoren eingeben
A = [-5 1; 1 0];
b = [1; -1];
c = [0 1];
d = 0;

% LTI Objekte erzeugen mit ss()
zstm = ss(A, b, c, d);

% G(s) (Übertragungsfkt) ausgeben lassen
ueft = tf(zstm);
[z, n] = tfdata(ueft);
% zaehler nenner
z_uetf = z{1, 1}
n_uetf = n{1, 1}
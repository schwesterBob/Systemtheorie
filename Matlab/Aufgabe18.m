%Aufgabe18
home
clear
close all

%G(s) eingeben
s = tf('s');

sys = (3*s + 12)/(((s*s) + 2*s +4)*(s + 6));

%Pol-/Nst zeichen
pzmap(sys)

% H(s) aus G(s) ermitteln
H = sys * (1/s)

% Partialbruchzerlegung von H(s) durchführen
[z , n] = tfdata(H);
[r, p ,k] = residue(z{1,1}, n{1,1});

% r p k ausgeben
r
p
k

% Term mit Polst bei s= -6 abziehen (siehe notiz)
H1 = H - r(1)/(s - p(1))

% Vergleich der Sprungantworten
figure(2)
impulse(H, H1)
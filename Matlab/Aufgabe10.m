%Aufgabe 10

home
clear
close all

dt = 0.1;
te = 100;
%Zeitvektor festlegen
t = 0:dt:te;

%Zeitsignal definieren s(t)
s = 3 *(sigma_(t)-sigma_(t-2));

%Fast Fouriertransformation berechnen
S = fft(s)*dt;

%Spektrum verschieben
S = fftshift(S); %versuchhalber mal weglassen

%plotten über frequenz nicht über t!!
fmax = 1/(2*dt);
df = 1/te; %df verkleinern indem te vergrößert wird
%Frequenz festlegen
f = -fmax:df:fmax;
omega = 2 * pi * f;

Skomp = S .* exp(-j*omega*dt/2);
%Darstellung von Betrag (abs())) und Phase (angle()) mit subplot
% drei bilder s(t), betrag S, Phase
subplot( 3, 1, 1);
plot(t, s, 'Linewidth',2);
subplot( 3, 1, 2);
plot(omega, abs(Skomp), 'Linewidth',2);
subplot( 3, 1, 3);
plot(omega, angle(Skomp), 'Linewidth',2);

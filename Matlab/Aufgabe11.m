%Aufgabe 11

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


%%%%%%%
%2 Varianten implementieren:
% 1)Quadrierung des Spektrums aus A10 y1(w) = S(w)^2 (exp(x))
y1 = S.^2;

% 2) zunächst (mit conv) y2(t) = s(t) *(faltung) s(t)
%    dann Spektrum Y2(w) aus Y2(t) ermitteln
y2 = conv(S,S)*dt;
y2 = y2(1:length(s));
Y2 = fft(y2);
Y2 = fftshift(Y2)*dt;
Y2komp = Y2.*exp(-j*omega*dt/2);

%Darstellung von Betrag (abs())) und Phase (angle()) mit subplot
% drei bilder s(t), betrag S, Phase
subplot( 3, 1, 1);
plot(omega, y1, 'Linewidth',2);
subplot( 3, 1, 2);
plot(omega, abd(y2), 'Linewidth',2);
subplot( 3, 1, 2);
plot(omega, angle(Y2), 'Linewidth',2);

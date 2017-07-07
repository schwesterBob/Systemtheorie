% Programm "ml_demo_5_3".
% Demonstrationsprogramm zur Anwendung von Matlab 5.3
% in der Systemtheorie zur Analyse kontinuierlicher
% und zeitdiskreter Systeme im Zeit-, Bild- und
% Frequenzbereich.
%
% (Die als Berechnungs- oder Umrechnungsbefehle
% bezeichneten Matlab-Befehle f�hren im Kern die in
% den jeweiligen Programmteil-�berschriften genannten
% Berechnungen aus)
clear % Arbeitsspeicher s�ubern
home % Cursor in linke obere Bildecke
close all % alle Grafiken schlie�en
format short e % genauere Zahlendarstellung
% Eingabe des Systems in Form seines Zustandsmodells.
%
disp('Eingegebenes Zustandsmodell')
% Textausgabe
%A=[0,0,-0.2;1 ,0,-1.1;0,1,-0.7];
% Systemmatrix
%b=[5;10;0]; % Eingangsvektor
%c=[0,0,1]; % Ausgangsvektor
%d=0; % Durchgangsfaktor
% Alternativ w�hlbares System
%
A=[0,0,-6;1,0,-11;0,1,-6];
b=[1;0;0];
c=[0,0,1];
d=0;
%
k_ss_sys=ss(A,b,c,d); % kontinuierliches Zustandsmodell-Objekt
pause % stoppt den Programmlauf bis
% CR-Eingabe.
home
% �bergang von Zeitbereich in den Bildbereich:
% Berechnuung der �bertragungsfunktion in Polynomform
% aus dem Zustandsmodell.
%
disp('�bertragungsfunktion in Polynomform')
[k_tf_sys]=tf(k_ss_sys); % Wandlungsbefehl
pause
home

% Extrahierung des Z�hler- und Nennerpolynoms der
% �bertragungsfunktion aus dem �bertragungsfunktions-
% Objekt "k_tf_sys".
%
[zk_cell,nk_cell]=tfdata(k_tf_sys);
% Berechnung der Cell-Arrays
% des Z�hler- und Nennerpolynoms.
zk=zk_cell{1}; % Koeff.-Vektor des Z�hlers;
nk=nk_cell{1}; % Koef.-Vektor des Nenners;
% Umrechnungen der �bertragungsfunktion in ihre
% verschidenen Darstellungsformen
%
% Umrechnung der �bertragungsfunktion in Produktform
%
disp('�bertragungsfunktion in Produktform')
[null,pol,k]=tf2zp(zk,nk); % Umrechnungsbefehl
Zaehlernullstellen=null; % Ergebnisausgabe
Nennernullstellen=pol;
Faktor=k;
pause
home
%
% Umrechnung der �bertragungsfunktion in Partialbruchform
% (Berechnet keine sinnvollen Ergebnisse bei komplexen
% Pol- oder Nullstellen)
%
disp('�bertragungsfunktion in Partialbruchform')
[r,p,k]=residue(zk,nk); % Umrechnungsbefehl
Zaehler=r; % Ergebnisausgabe
Pole=p;
Faktor=k;
pause
home
%
% Umrechnung der �bertragungsfunktion in die V-Normalform
%
disp('�bertragungsfunktion in V-Normalform')
tf2vn(zk,nk); % Umrechnungsbefehl,
% geh�rt nicht zum Matlab-
% befehlsvorrat.
pause
home
% Berechnung von Systemantworten
%
tend=25; % Darstellungsintervall-L�nge
dt=0.01; % Rechenschrittweite
t=0:dt:tend; % Zeitachse
figure(1) % erster Grafik-Bildschirm
%
% Impulsantwort
%
g=impulse(k_ss_sys,t); % Berechnungsbefehl
subplot(3,1,1) % Plot in erste "Zeile" von drei
% m�glichen.
plot(t,g) % eigentlicher Plot-Befehl
grid on % Gitternetz �ber Grafik
title('Impulsantwort') % Titel �ber Grafik
%
% Sprungantwort
%
h=step(k_ss_sys,t); % Berechnungsbefehl
subplot(3,1,2) % Plot in zweite "Zeile" von drei
% m�glichen.
plot(t,h)
grid on
title('Sprungantwort')
%
% Antwort auf eine beliebige Erregung
%
u=stepfun(t,0)-stepfun(t,5); % Erregungssignalgenerierung:
% hier: Puls von 5sek. Dauer,
% Ampliude=1
[y,t,x]=lsim(k_ss_sys,u,t); % Berechnungsbefehl
subplot(3,1,3) % Plot in dritte "Zeile" von drei
% m�glichen.
plot(t,y,'y',t,u,'r') % Ausgabe der Einganserregung (rot)
% und der Systemantwort (gelb).
grid on
title('Beliebige Erregung (rot eingezeichnet)')
xlabel('t / sek') % Beschriftung der x-Achse
pause
home
%
% Zustandsgr��enverl�ufe bei der oben gew�hlten Erregung
%
figure(2) % zweiter Grafik-Bildschirm
subplot(3,1,1)
plot(t,x(:,1)) % 1. Spalte der Zustandsgr��en x
% (siehe "lsim")
grid on
title('Zustandsgr��e 1 bei beliebiger Erregung')
subplot(3,1,2)
plot(t,x(:,2)) % 2. Spalte der Zustandsgr��en x
% (siehe "lsim")
grid on
title('Zustandsgr��e 2 bei beliebiger Erregung')
subplot(3,1,3)
plot(t,x(:,3)) % 3. Spalte der Zustandsgr��en x
% (siehe "lsim")
grid on
title('Zustandsgr��e 3 bei beliebiger Erregung')
xlabel('t / sek')
pause
home
% Systemanlayse im Bildbereich:
% Pol-/Nullstellenverteilung
figure(3) % dritter Grafikbildschirm
pzmap(k_ss_sys) % Berechnungsbefehl
% mit direkter Grafikausgabe
grid
title('Pol- / Nulstellen-Plan')
pause
% Systemanalyse im Frequenzbereich:
% Bodediagram
w=logspace(-2,2,600); % Omega-Achse

[betrag,phas]=bode(k_ss_sys,w); % Berechnungsbefehl
bdB=20*log10(betrag); % dB-Berechnung
bdB=reshape(bdB,[1,length(w)]);
phas=reshape(phas,[1,length(w)]);
% Wandlung der von "bode"
% erzeugten 3-D Matrizen in
% Zeilen-Vektoren (zum Plotten).
figure(4) % vierter Grafikbildschirm
subplot(2,1,1) % Plot der Betragskennlinie
% in erste "Zeile" von
% zwei m�glichen
semilogx(w,bdB) % Plot-Befehl f�r logarith-
% mische x-Achse
grid on
title('Bodediagramm: Betragskennlinie')
ylabel('dB') % Beschriftung der y-Achse
subplot(2,1,2) % Plot der Phasenkennlinie
% in die zweite "Zeile" von
% zwei m�glichen
semilogx(w,phas)
grid on
title('Phasenkennlinie')
xlabel('omega [1/sek]')
ylabel ('Grad')
% �bergang zur Zeitdiskreten Systemen
%
% Diskretisierung des kontinuierlichen Systems
%
T=1; % gew�hlte Abtastzeit
disp('Zeitdiskrete �bertragungsfunktion (Polynomform)')
d_tf_sys=c2d(k_tf_sys,T,'zoh'); % Umrechnungsbefehl
pause
home
% Diskrete Systemantworten
%
td=0:T:tend-T; % diskrete Zeitachse
%
% Diskrete Impulsantwort
%
gd=impulse(d_tf_sys,td); % Berechnungsbefehl
figure(5)
subplot(3,1,1)
stairs(td,gd)
grid on
title('Diskrete Impulsantwort')
%
% Diskrete Sprungantwort
%
gd=step(d_tf_sys,td); % Berechnungsbefehl
subplot(3,1,2)
stairs(td,gd)
grid
title('Diskrete Sprungantwort')

%
% Diskrete Systemantwort auf beliebige Erregung
%
ud=stepfun(td,0)-stepfun(td,5);
% Erregungssignalgenerierung
% Puls von 5sek. Dauer,
% Ampliude=1.
yd=lsim(d_tf_sys,ud,td); % Berechnungsbefehl
subplot(3,1,3)
stairs(td,yd,'y')
hold on
stairs(td,ud,'r')
grid on
hold off
title('Beliebige Erregung (rot eingezeichnet)')
xlabel('t / sek')
pause
home
% Systemanalyse im Bildbereich:
% Pol-/Nullstellenverteilung des diskreten Systems
%
figure(6)
pzmap(d_tf_sys) % Berechnungsbefehl
zgrid % spezielles Gitternetz
% f�r zeitdiskrete Systeme
title('Pol- / Nulstellen-Plan')
pause
% Systemanalyse im Frequenzbereich:
% Bodediagram des diskreten Systems
%
w=logspace(-2,2,800);
[betrag,phas]=bode(d_tf_sys,w); % Berechnungsbefehl
bdB=20*log10(betrag);
bdB=reshape(bdB,[1,length(w)]);
phas=reshape(phas,[1,length(w)]);
% Wandlung der von "bode"
% erzeugten 3-D Matrizen in
% Zeilen-Vektoren (zum Plotten).
figure(7)
subplot(2,1,1)
semilogx(w,bdB)
grid on
title('Bodediagramm: Betragskennlinie')
ylabel('dB')
subplot(2,1,2)
semilogx(w,phas)
grid on
title('Phasenkennlinie')
xlabel('omega [1/sek]')
ylabel ('Grad')
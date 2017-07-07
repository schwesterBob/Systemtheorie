% Programm "ml_demo_5_3".
% Demonstrationsprogramm zur Anwendung von Matlab 5.3
% in der Systemtheorie zur Analyse kontinuierlicher
% und zeitdiskreter Systeme im Zeit-, Bild- und
% Frequenzbereich.
%
% (Die als Berechnungs- oder Umrechnungsbefehle
% bezeichneten Matlab-Befehle führen im Kern die in
% den jeweiligen Programmteil-Überschriften genannten
% Berechnungen aus)
clear % Arbeitsspeicher säubern
home % Cursor in linke obere Bildecke
close all % alle Grafiken schließen
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
% Alternativ wählbares System
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
% Übergang von Zeitbereich in den Bildbereich:
% Berechnuung der Übertragungsfunktion in Polynomform
% aus dem Zustandsmodell.
%
disp('Übertragungsfunktion in Polynomform')
[k_tf_sys]=tf(k_ss_sys); % Wandlungsbefehl
pause
home

% Extrahierung des Zähler- und Nennerpolynoms der
% Übertragungsfunktion aus dem Übertragungsfunktions-
% Objekt "k_tf_sys".
%
[zk_cell,nk_cell]=tfdata(k_tf_sys);
% Berechnung der Cell-Arrays
% des Zähler- und Nennerpolynoms.
zk=zk_cell{1}; % Koeff.-Vektor des Zählers;
nk=nk_cell{1}; % Koef.-Vektor des Nenners;
% Umrechnungen der Übertragungsfunktion in ihre
% verschidenen Darstellungsformen
%
% Umrechnung der Übertragungsfunktion in Produktform
%
disp('Übertragungsfunktion in Produktform')
[null,pol,k]=tf2zp(zk,nk); % Umrechnungsbefehl
Zaehlernullstellen=null; % Ergebnisausgabe
Nennernullstellen=pol;
Faktor=k;
pause
home
%
% Umrechnung der Übertragungsfunktion in Partialbruchform
% (Berechnet keine sinnvollen Ergebnisse bei komplexen
% Pol- oder Nullstellen)
%
disp('Übertragungsfunktion in Partialbruchform')
[r,p,k]=residue(zk,nk); % Umrechnungsbefehl
Zaehler=r; % Ergebnisausgabe
Pole=p;
Faktor=k;
pause
home
%
% Umrechnung der Übertragungsfunktion in die V-Normalform
%
disp('Übertragungsfunktion in V-Normalform')
tf2vn(zk,nk); % Umrechnungsbefehl,
% gehört nicht zum Matlab-
% befehlsvorrat.
pause
home
% Berechnung von Systemantworten
%
tend=25; % Darstellungsintervall-Länge
dt=0.01; % Rechenschrittweite
t=0:dt:tend; % Zeitachse
figure(1) % erster Grafik-Bildschirm
%
% Impulsantwort
%
g=impulse(k_ss_sys,t); % Berechnungsbefehl
subplot(3,1,1) % Plot in erste "Zeile" von drei
% möglichen.
plot(t,g) % eigentlicher Plot-Befehl
grid on % Gitternetz über Grafik
title('Impulsantwort') % Titel über Grafik
%
% Sprungantwort
%
h=step(k_ss_sys,t); % Berechnungsbefehl
subplot(3,1,2) % Plot in zweite "Zeile" von drei
% möglichen.
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
% möglichen.
plot(t,y,'y',t,u,'r') % Ausgabe der Einganserregung (rot)
% und der Systemantwort (gelb).
grid on
title('Beliebige Erregung (rot eingezeichnet)')
xlabel('t / sek') % Beschriftung der x-Achse
pause
home
%
% Zustandsgrößenverläufe bei der oben gewählten Erregung
%
figure(2) % zweiter Grafik-Bildschirm
subplot(3,1,1)
plot(t,x(:,1)) % 1. Spalte der Zustandsgrößen x
% (siehe "lsim")
grid on
title('Zustandsgröße 1 bei beliebiger Erregung')
subplot(3,1,2)
plot(t,x(:,2)) % 2. Spalte der Zustandsgrößen x
% (siehe "lsim")
grid on
title('Zustandsgröße 2 bei beliebiger Erregung')
subplot(3,1,3)
plot(t,x(:,3)) % 3. Spalte der Zustandsgrößen x
% (siehe "lsim")
grid on
title('Zustandsgröße 3 bei beliebiger Erregung')
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
% zwei möglichen
semilogx(w,bdB) % Plot-Befehl für logarith-
% mische x-Achse
grid on
title('Bodediagramm: Betragskennlinie')
ylabel('dB') % Beschriftung der y-Achse
subplot(2,1,2) % Plot der Phasenkennlinie
% in die zweite "Zeile" von
% zwei möglichen
semilogx(w,phas)
grid on
title('Phasenkennlinie')
xlabel('omega [1/sek]')
ylabel ('Grad')
% Übergang zur Zeitdiskreten Systemen
%
% Diskretisierung des kontinuierlichen Systems
%
T=1; % gewählte Abtastzeit
disp('Zeitdiskrete Übertragungsfunktion (Polynomform)')
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
% für zeitdiskrete Systeme
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
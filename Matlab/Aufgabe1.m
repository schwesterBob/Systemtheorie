%Aufgabe 1
%a) Generieren Sie in Matlab einen Zeilenvektor, der die ersten 50 nat�rlichen Zahlen
%enth�lt. Erzeugen Sie aus a durch Spiegelung den Zeilenvektor b, der die Zahlen in
%ungekehrter Reihenfolge enth�lt und erzeugen Sie einen weiteren Vektor c der
%L�nge 100, der nur Nullen enth�lt.
%b) Schreiben Sie die Vektoren a, b und c hintereinander in den neuen Vektor d, ermitteln
%Sie die L�nge von d und l�schen Sie dann die letzten f�nfzig Elemente aus
%dem Vektor d.
clear 
home
%a)
% start : step : range
a = 1 : 50
b = fliplr(a)
c = zeros(1,100);
%b
d = [a b c];
len = length(d)
D = d(1:len-50)
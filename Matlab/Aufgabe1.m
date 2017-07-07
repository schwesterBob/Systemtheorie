%Aufgabe 1
%a) Generieren Sie in Matlab einen Zeilenvektor, der die ersten 50 natürlichen Zahlen
%enthält. Erzeugen Sie aus a durch Spiegelung den Zeilenvektor b, der die Zahlen in
%ungekehrter Reihenfolge enthält und erzeugen Sie einen weiteren Vektor c der
%Länge 100, der nur Nullen enthält.
%b) Schreiben Sie die Vektoren a, b und c hintereinander in den neuen Vektor d, ermitteln
%Sie die Länge von d und löschen Sie dann die letzten fünfzig Elemente aus
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
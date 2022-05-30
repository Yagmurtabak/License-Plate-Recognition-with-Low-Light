%CREATE TEMPLATES 
%Alphabets :
A=imread('Alphanumerics/A.bmp');B=imread('Alphanumerics/B.bmp');C=imread('Alphanumerics/C.bmp');
D=imread('Alphanumerics/D.bmp');E=imread('Alphanumerics/E.bmp');F=imread('Alphanumerics/F.bmp');
G=imread('Alphanumerics/G.bmp');H=imread('Alphanumerics/H.bmp');I=imread('Alphanumerics/I.bmp');
J=imread('Alphanumerics/J.bmp');K=imread('Alphanumerics/K.bmp');L=imread('Alphanumerics/L.bmp');
M=imread('Alphanumerics/M.bmp');N=imread('Alphanumerics/N.bmp');O=imread('Alphanumerics/O.bmp');
P=imread('Alphanumerics/P.bmp');Q=imread('Alphanumerics/Q.bmp');R=imread('Alphanumerics/R.bmp');
S=imread('Alphanumerics/S.bmp');T=imread('Alphanumerics/T.bmp');U=imread('Alphanumerics/U.bmp');
V=imread('Alphanumerics/V.bmp');W=imread('Alphanumerics/W.bmp');X=imread('Alphanumerics/X.bmp');
Y=imread('Alphanumerics/Y.bmp');Z=imread('Alphanumerics/Z.bmp');

%Numbers :
one=imread('Alphanumerics/1.bmp');two=imread('Alphanumerics/2.bmp');
three=imread('Alphanumerics/3.bmp');four=imread('Alphanumerics/4.bmp');
five=imread('Alphanumerics/5.bmp'); six=imread('Alphanumerics/6.bmp');
seven=imread('Alphanumerics/7.bmp');eight=imread('Alphanumerics/8.bmp');
nine=imread('Alphanumerics/9.bmp'); zero=imread('Alphanumerics/0.bmp');

%Creating Array for Alphabets
letter=[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z];
%Creating Array for Numbers
number=[one two three four five six seven eight nine zero];

NewTemplates=[letter number];
save ('NewTemplates','NewTemplates')
clear all
% Pruebas
A = [ -2 2; 1 -5];
B = [1/2; 0];
C = [1 0; 0 1];
D = [0; 0];
M = ss(A,B,C,D);
step(M);

s = tf ('s');
H = 1/(s+1);
t = linspace(0,2*pi,1000);
u = sin(t);
lsim(H,u,t);

A=[-2 2; 1 -5];
B = [1/2; 0];
C = [1 0; 0 1];
D = [0; 0];
M = ss(A , B , C,D );
M_z = c2d(M, 1e-4 , 'zoh');
step(M_z);

% Desarrollo

% PREGUNTA 1
a = 1;
b = 1;
c = 1;
d = 1;
e = 1;
f = 1;

s = tf('s');
H1 = a/(b*s - c);
H2 = d/(e*s-f);

step(feedback(H1, H2));

[A,B,C,D] = bam(a,b,c,d,e,f);
M = ss(A,B,C,D);
step(M);

[numerador,denominador] = mab(A,B,C,D);

s = tf ('s');
XD = s*eye(2)

[num,den] = ss2tf(A,B,C,D)

H1 = mab(A,B,C,D);

% PREGUNTA 2

% Se transforma el modelo de estado
% a funcion de transferencia con la 
% funcion mab

A2 = [-0.4125 0.3125 ; 0.3125 -0.4125];
B2 = [1 ; 1];
C2 = [1 0 ; 0 1];
D2 = [0; 0];

H3 = mab(A2,B2,C2,D2);

% Se calculan las respuestas

% Escalon
escalon = step(H3);

% Impulso
impulso = impulse(H3);

% u(t)
t = linspace(0, 12*pi , 5000);
u = 100* sin(t/4);
u(u<0) = 0.;

ut = lsim(H3, u, t);


% PREGUNTA 3

% Se obtiene el modelo de estado de 
% un sistema

T1 = 0.001;
T2 = 0.1;
T3 = 2;

M2 = ss(A2, B2, C2, D2);

M_z1 = c2d(M2, T1,'zoh');
M_z2 = c2d(M2, T2,'zoh');
M_z3 = c2d(M2, T3,'zoh');

t = 1:70;

% step(M_z1)
% step(M_z2)
% step(M_z3)
step(M_z1, M_z2, M_z3)

M_f1 = c2d(M2, T1,'foh');
M_f2 = c2d(M2, T2,'foh');
M_f3 = c2d(M2, T3,'foh');

% step(M_f1)
% step(M_f2)
% step(M_f3)
step(M_f1, M_f2, M_f3)













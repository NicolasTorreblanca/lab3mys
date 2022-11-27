% Laboratorio 3 Modelación y Simulación
% Nicolás Torreblanca
% Rodrigo Escobar

% Desarrollo

% ############ PRIMERA PARTE ############
% Se definen valores arbitrarios para las variables
a = 1;
b = 1;
c = 1;
d = 1;
e = 1;
f = 1;

% Se definen las funciones de transferencia del
% diagrama de bloques
s = tf('s');
H1 = a/(b*s - c);
H2 = d/(e*s-f);

% Se calcula la funcion de transferencia del sistema
H_total = feedback(H1, H2);

% Se calcula la funcion de tranferencia con las
% funciones bam y mab
[A1,B1,C1,D1] = bam(a,b,c,d,e,f);
H_mab = mab(A1,B1,C1,D1);

% Se comparan las respuestas al escalón con
% cada funcion de transferencia obtenida de
% manera diferente
figure(1);
step(H_total, H_mab);
title('Comparación función feedback v/s función mab');
legend("Respuesta con Feedback","Respuesta con mab");

% ################################################

% ############ SEGUNDA PARTE ############

% Se transforma el modelo de estado
% a funcion de transferencia con la 
% función mab
A2 = [-0.4125 0.3125 ; 0.3125 -0.4125];
B2 = [1 ; 1];
C2 = [1 0 ; 0 1];
D2 = [0; 0];

H2 = mab(A2,B2,C2,D2);
% H21 = ss(A2,B2,C2,D2);

% Se calculan las respuestas

% Escalón
escalon = step(H2);
t1 = linspace(0,60,449)

% Impulso
impulso = impulse(H2);

% Función u(t)
t2 = linspace(0, 12*pi , 5000);
u = 100* sin(t2/4);
u(u<0) = 0.;
u_t = lsim(H2, u, t2);

plot(t1,transpose(escalon(:,1)), t1, transpose(impulso(:,1)), t2, transpose(u_t(:,1)))
title('Comparación de respuestas con distintas entradas');
legend("Respuesta a escalón","Respuesta a impulso", "Respuesta a u(t) = 100* sin(t/4)");

% ################################################

% ############ TERCERA PARTE ############

% Se obtiene el modelo de estado de 
% un sistema
M2 = ss(A2, B2, C2, D2);

% Se definen los 3 tiempos de muestreo
T1 = 0.001;
T2 = 0.1;
T3 = 2;

% Se calculan las discretizaciones
% con los 3 tiempos de muestreo
M_z1 = c2d(M2, T1,'zoh');
M_z2 = c2d(M2, T2,'zoh');
M_z3 = c2d(M2, T3,'zoh');

% Se comparan los resultados con la discretización zoh
figure(5)
step(M_z1, M_z2, M_z3)
title('Discretizaciones zero order hold con tiempo de muestreo distinto');
legend("T = 0.001","T = 0.1", "T = 2");

% Se calculan las discretizaciones
% con los 3 tiempos de muestreo
M_f1 = c2d(M2, T1,'foh');
M_f2 = c2d(M2, T2,'foh');
M_f3 = c2d(M2, T3,'foh');

% Se comparan los resultados con la discretización foh
figure(6)
step(M_f1, M_f2, M_f3)
title('Discretizaciones first order hold con tiempo de muestreo distinto');
legend("T = 0.001","T = 0.1", "T = 2");

% ################################################











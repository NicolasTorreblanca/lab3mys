% Laboratorio 3 Modelación y Simulación
% Nicolás Torreblanca
% Rodrigo Escobar

% Desarrollo

% ############ PRIMERA PARTE ############

% Se solicita generar 2 funciones, bam y mab

% bam : Dado 6 parametros debe generar las matrices de modelo de estado
% mab : A partir de las matrices de un modelo de estado, obtener la función
%       de transferencia del sistema.

% Despues, para probar el funcionamiento, se debe aplicar bam y mab en un
% diagrama de bloques, para luego comparar los resultados obtenidos con una
% función feedback(que igual permite generar funciones de transferencia)
% ante un impulso como entrada.

% Con el desarrollo algebraico, es posible plantear las matrices de bam

% A = [c/b -a/b ; d/e f/e];
% B = [a/b ; 0]; 
% C = [1 0];
% D = [0]; 

% Con esto asegurado podemos plantear los parametros.
a = 1;
b = 1;
c = 1;
d = 1;
e = 1;
f = 1;

% Por lo que para que bam no tenga complicaciones debemos aplicar la
% restricción a los valores b y e, que estrictamente deben ser distintos de
% 0. Para asegurarnos que se cumpla la restricción de plantea una decisión.

if b == 0 || d == 0 
   disp('Indefinicion de la division, probar con valores distintos de 0 para b y/o d');
else
    [A1,B1,C1,D1] = bam(a,b,c,d,e,f);
    H_mab = mab(A1,B1,C1,D1);

% Despues de esto, se genera la función de transferencia que se
% crea con feedback, con el fin de comparar con la función de transferencia
% obtenida en mab
% Declaramos cada bloque,y se calcula la función de transferencia
   
    s = tf('s');
    H1 = a/(b*s - c);
    H2 = d/(e*s-f);
    H_total = feedback(H1, H2);

% Se comparan las respuestas al escalón con cada funcion de transferencia 
% obtenida de manera diferente
    
    figure(1);
    step(H_total, H_mab);
    title('Comparación función feedback v/s función mab');
    legend("Respuesta con Feedback","Respuesta con mab");
   
end

% ################################################

% ############ SEGUNDA PARTE ############

% En esta parte se solicita estudiar un sistema mediante un modelo de
% estado. Luego del desarrollo algebraico es posible plantear la matriz de
% modelo de estados, cuyas matrices A,B,C y D corresponden a:

A2 = [-0.4125 0.3125 ; 0.3125 -0.4125];
B2 = [1 ; 1];
C2 = [1 0 ; 0 1];
D2 = [0; 0];

% Con lo que podemos calcular la función de transferencia utilizando la 
% Funcion Mab

H2 = mab(A2,B2,C2,D2);

% Se calculan las respuestas

% Escalón
escalon = step(H2);
t1 = linspace(0,60,449);

% Impulso
impulso = impulse(H2);

% Función u(t)
t2 = linspace(0, 12*pi , 5000);
u = 100* sin(t2/4);
u(u<0) = 0.;
u_t = lsim(H2, u, t2);

figure(2)
plot(t1,transpose(escalon(:,1)), t1, transpose(impulso(:,1)), t2, transpose(u_t(:,1)))
title('Comparación de respuestas con distintas entradas');
legend("Respuesta a escalón","Respuesta a impulso", "Respuesta a u(t) = 100* sin(t/4)");
xlim([0 40])
xlabel("Tiempo(s)")
ylabel("Amplitud")

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
figure(3)
step(M_z1, M_z2, M_z3)
title('Discretizaciones zero order hold con tiempo de muestreo distinto');
legend("T = 0.001","T = 0.1", "T = 2");

% Se calculan las discretizaciones
% con los 3 tiempos de muestreo
M_f1 = c2d(M2, T1,'foh');
M_f2 = c2d(M2, T2,'foh');
M_f3 = c2d(M2, T3,'foh');

% Se comparan los resultados con la discretización foh
figure(4)
step(M_f1, M_f2, M_f3)
title('Discretizaciones first order hold con tiempo de muestreo distinto');
legend("T = 0.001","T = 0.1", "T = 2");

% ################################################











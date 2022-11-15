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










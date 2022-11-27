% Funcion bam
% Entradas : flotante x flotante x flotante x flotante x flotante x flotante 
% Salidas  : Matriz x Matriz x Matriz x Matriz
% Funcionamiento : Calcula las matrices de un modelo de estados
%                  dado determinados parametros de entrada.

function [A,B,C,D] = bam(a,b,c,d,e,f)
    A = [c/b -a/b ; d/e f/e];
    B = [a/b ; 0];
    C = [1 0];
    D = [0];
end


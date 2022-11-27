% Funcion mab
% Entradas : Matriz x Matriz x Matriz x Matriz
% Salidas  : Funcion de transferencia
% Funcionamiento : Calcula una función de transferencia a partir de las
%                  4 matrices de modelo de estados.

function H = mab(A,B,C,D)
    s = tf ('s');
    H = C * (inv(s*eye(2) - A)) * B + D;
end


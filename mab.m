function H = mab(A,B,C,D)
    s = tf ('s');
    H = C * (inv(s*eye(2) - A)) * B + D;
end


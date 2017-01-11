function [tau]=kendall(x,y)
% The program is used for calculating the Kendall's rank correlation
% coefficent between two variables using the method provided by 
% Gibbons(1992).
%
% Coded by Huihui Li
% Peking University.
n = length(x);
s = 0;
for i = 1:n-1
    s = s + sum(sign((x(i)-x(i+1:n)).*sign(y(i)-y(i+1:n))));
end
tau = 2*s/(n*(n-1));




% function M(L[1..n], R[1..m])
    % i := 1
    % j := 1
    % nSwaps := 0
    % while i <= n  and j <= m do
        % if R[j] < L[i] then
            % nSwaps := nSwaps + n - i + 1
            % j := j + 1
        % else
            % i := i + 1
    % return nSwaps
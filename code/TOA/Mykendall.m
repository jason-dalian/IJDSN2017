function [Kendall_tau]= Mykendall(A,B)

n=length(A);
num_same=0;   %相同对数；
num_diff=0;   %不同对数；

for i=1:(n-1)
    for j=i+1:n
        for k=1:n
            if (B(k)==A(i)||B(k)==A(j))
                if B(k)==A(i)
                num_same=num_same+1;
                end
                if B(k)==A(j)
                num_diff=num_diff+1;
                end
            break;
            end
            
                   
        end
    end
end
num_same;
num_diff;
tau=num_same-num_diff;

Kendall_tau=2*tau/(n*(n-1));




% n = length(A);
% s = 0;
% for i = 1:n-1
%     s = s + sum(sign((A(i)-A(i+1:n)).*sign(B(i)-B(i+1:n))));
% end
% Kendall_tau1 = 2*s/(n*(n-1));
% 
% 
% Kendall_coeff = corr(A' , B' , 'type' , 'Kendall');  

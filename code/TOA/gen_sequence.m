function b= gen_sequence(n)

a=1:n;
for i=n:-1:1
    m=floor(1+length(a)*rand);
    b(i)=a(m);
    a(m)=[];
end

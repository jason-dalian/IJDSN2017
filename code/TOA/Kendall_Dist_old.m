function Kendall_tau = Kendall_Dist(B1, B2)  
[m1,n1]=size(B1);
[m2,n2]=size(B2);

%%%%%%%%%%%%%%%%éœ?¦æ˜¯n*1çš„çŸ¢é‡?
sizedata=size(B1);
 if sizedata(2)~=1
B1=B1';
end

sizedata=size(B2);
 if sizedata(2)~=1
B2=B2';
end


NN1=max(m1,n1); %%%length
NN2=max(m2,n2);

if NN1~=NN2
 disp('error');
 Dh=10000;
end    

len=NN1;


%Spearman Rank order correlation coeffcient
for i=1:len
d(i)=(B1(i)-B2(i)).^2;
end   
 Spearman_coeff=1-6*sum(d)/(len*len*len-len);
 
 
%data=[B1 B2];
%Kendall_tau=ktaub(data,0.5,0);
%Kendall_tau_1=corr(B1,B2,'type','Kendall') %%lowly

Kendall_tau=kendall(B1,B2); %faster


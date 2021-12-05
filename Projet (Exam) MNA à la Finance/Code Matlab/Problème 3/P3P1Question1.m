
Graphe_Prix_Option_ASSET_SAUT(1000)

function [] = Graphe_Prix_Option_ASSET_SAUT(Nmc)
N=100;
L=30;
for j=1:(N+1)
    S0(j)=L*(j-1)/N;
    prix_option_saut(j)=Prix_S0fixe(S0(j),Nmc);
end

% Question 1

figure;
plot(S0,prix_option_saut);
legend('V(t=0,S)');
title('Prix de l option ASSET avec SAUT t=0 par MC pour N_{mc}=10000')

end


function [prix]=Prix_S0fixe(S0,Nmc)

T=0.5;
K=10;
r=0.4;
sigma=0.5;
lambda=25;
J=0.17;
mu=r-lambda*(exp(J)-1);
sum=0;

for n=1:Nmc
    ST=S0*exp((mu-(sigma^2)/2)*T+sigma*sqrt(T)*randn+Nt(lambda,T)*J);
    if ST<K
        gain=ST;
     else    
        gain=0; 
     end
    sum=sum+gain;
end
prix=exp(-r*T)*(sum/Nmc);
end


function [Nsauts]=Nt(lambda,t)
n=0;
Tsauts=0;
while Tsauts < t
    ExpSaut=-log(randn)/lambda;
    Tsauts=Tsauts+ExpSaut;
    n=n+1;
end
Nsauts=n-1;
end



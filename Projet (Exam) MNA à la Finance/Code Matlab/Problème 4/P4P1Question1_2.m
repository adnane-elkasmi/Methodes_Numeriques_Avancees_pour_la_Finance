
Prix_Asiatique(1000)

function [] = Prix_Asiatique(Nmc)

L=30;
K=10;

ds=1;

for k=1:L+1
    S0(k)=k-1;
    prix_option(k)=Prix_Asiatique_S0_fixe(S0(k),Nmc);
end

% Question 1
fprintf("V(t=0,S=9)=%f",prix_option(1,floor(9/(ds))+1));

% Question 2
plot(S0,prix_option)
xlabel('S_0')
ylabel('V(0,S_0)')
legend('Prix Option Asiatique à t=0')
title('Graphe du prix de lOption Asiatique par MC pour N_{mc}=1000')



end

function [prix] = Prix_Asiatique_S0_fixe(S0,Nmc)

T=0.5;
r=0.4;
sum=0;

for k=1:Nmc
    sum=sum+Payoff_asiatique(S0);
end

prix=exp(-r*T)*(sum/Nmc);

end

function [res] = Payoff_asiatique(S0)

K=10;
T=0.5;
r=0.4;
sigma=0.5;
S(1)=S0;
N=100;
dt=T/N;
produit=1;

for i=1:N
    S(i+1)=S(i)*exp((r-(sigma^2)/2)*dt+sigma*sqrt(dt)*randn);
    produit=produit*S(i);
end

moyenne_geometrique=(produit)^(1/N);

res=max(K-moyenne_geometrique,0);

end
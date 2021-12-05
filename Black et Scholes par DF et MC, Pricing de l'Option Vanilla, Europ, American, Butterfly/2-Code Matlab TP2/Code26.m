
Graphe_Call()

function [] = Graphe_Call()

% Définition des constantes et vecteurs %

L=20;
T=0.5;
Ns=49;
t=T/2;

for j=1:(Ns+1)
    St(j)=(L/Ns)*(j-1);
    prix_graphe(j)=Prix_Call_St_fixe_t_fixe(t,St(j));
end

figure;
plot(St,prix_graphe)
xlabel('Prix S_t')
ylabel('V(t=T/2,S_t)')
title('Graphe du prix call de l option Europ par MC pour N_{mc}=1000')

end

function [prix] = Prix_Call_St_fixe_t_fixe(t,St)

% Définition des constantes et vecteurs %

K=10;
T=0.5;
r=0.1;
sigma=0.5;
Nmc=1000;

for n=1:Nmc
    ST(n)=St*exp((r-(sigma^2)/2)*(T-t)+sigma*sqrt(T-t)*randn);
    gain(n)=Payoff_Europ_Call(ST(n),K);
end

prix=exp(-r*(T-t))*mean(gain);

end

function [f] = Payoff_Europ_Call(S,K)
f=max(S-K,0);
end

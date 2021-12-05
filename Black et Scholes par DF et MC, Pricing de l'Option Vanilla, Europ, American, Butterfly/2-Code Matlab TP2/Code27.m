
Surface_Call_Europe()

function [] = Surface_Call_Europe()

% Définition des constantes et vecteurs %

L=20;
T=0.5;
Ns=49;
Nt=10;

for j=1:(Ns+1)
    for k=1:(Nt+1)   
    St(j)=(L/Ns)*(j-1);
    t(k)=(T/Nt)*(k-1);
    prix_graphe(k,j)=Prix_Call_St_fixe_t_fixe(t(k),St(j));
    end
end

figure;
mesh(St,t,prix_graphe)
xlabel('Prix de l actif S_t')
ylabel('temps t')
zlabel('Prix de l option V')
title('Surface du prix call de l option Europ par MC pour N_{mc}=1000')

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


surface_Asset_Barriere()

function [] = surface_Asset_Barriere()

% Définition des constantes et vecteurs %

L=30;
T=0.5;
Ns=100;
Nt=100;
ds=L/Ns;
B=12;

for j=1:(Ns+1)
    for k=1:(Nt+1)   
    St(j)=(L/Ns)*(j-1);
    t(k)=(T/Nt)*(k-1);
    if St(j)<B
    V(k,j)=Prix_Asset_Barriere_St_fixe_t_fixe(t(k),St(j));
    else
    V(k,j)=Prix_Asset_Barriere_St_fixe_t_fixe(t(k),0);
    end
    end
end


% Question 1

fprintf("V(t=0,S0=6)=%f",V(1,floor(6/(ds))+1));

% Question 2

figure;
hold on;
plot(St,V(1,:));
legend('V(t=0,S)');
title('Prix de l option t=0 par MC pour N_{mc}=1000')


% Question 3

figure;
mesh(St,t,V)
xlabel('Prix de l actif S_t')
ylabel('temps t')
zlabel('Prix de l option V')
title('Surface du prix de loption par MC pour N_{mc}=1000')

end

function [prix] = Prix_Asset_Barriere_St_fixe_t_fixe(t,St)

% Définition des constantes et vecteurs %

B=12;
K=10;
T=0.5;
r=0.4;
sigma=0.5;
Nmc=1000;

for n=1:Nmc
    if St<B  
    ST(n)=St*exp((r-(sigma^2)/2)*(T-t)+sigma*sqrt(T-t)*randn);
    gain(n)=Payoff_Asset_Barriere(ST(n),K);
    else
    gain(n)=Payoff_Asset_Barriere(0,K);
    end
end

prix=exp(-r*(T-t))*mean(gain);

end

function [f] = Payoff_Asset_Barriere(S,K)

B=12;

if (S < K)
    f=S; 
elseif (S >= K)
    f=0;
elseif (S >= B)    
    f=0;
end

end

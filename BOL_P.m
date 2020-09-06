clear 
clc

ncomp = 2; % numero de componentes da mistura

x(1) = 0.5; % benzeno
x(2) = 0.5; % tolueno

T = 113; % C

p = Antoine.data;
%disp(p)

bnz = p.bnz;
tol = p.tol;

P(1) = bnz.Psat(T)*x(1); % mmHg
P(2) = tol.Psat(T)*x(2); % mmHg

Ptot = sum(P); % mmHg
disp('P bolha em mmHg:')
disp(Ptot)

y(1) = bnz.Psat(T)/Ptot*x(1); 
y(2) = tol.Psat(T)/Ptot*x(2);

y_bnz = @(P) bnz.Psat(T)/P*x(1);
y_tol = @(P) tol.Psat(T)/P*x(1);

disp(y_bnz(Ptot))
disp(y_tol(Ptot))

P = Ptot - 600:Ptot+600;

ybnz = zeros(length(P),1);
ytol = zeros(length(P),1);

for i = 1:length(P)
   ybnz(i) = y_bnz(P(i));
   ytol(i) = y_tol(P(i));
end

figure(1)
plot(P,ybnz+ytol,'k-.','LineWidth',2);
hold on
plot(P,ybnz,'r-','LineWidth',2);
plot(P,ytol,'b--','LineWidth',2);
plot(Ptot,y_bnz(Ptot),'sr','MarkerSize',15);
plot(Ptot,y_tol(Ptot),'sb','MarkerSize',15);
plot(Ptot,1,'sk','MarkerSize',15);
ylim([0 1.2])
xlabel('Pressao (mmHg)')
ylabel('Fracao molar no vapor')
title('Benzeno e Tolueno fracoes molares no vapor')
legend('y_{bnz}+y_{tol}','y_{bnz}','y_{tol}','Location','NE')
hold off






















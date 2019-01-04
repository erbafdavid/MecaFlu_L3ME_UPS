%
% Fichier de commande pulse.m
% visualisation de l'ecoulement pulse en conduite
%

function pulse

close all;

global omega;
omega = input('Pulsation (adimensionnee - par ex. 0.001 ou 1000) : ');

% Domaine de calcul (on raffine pres des parois...)
y1 = linspace(-1, -0.8, 30);
y2 = linspace(-0.8, 0.8, 40);
y3 = linspace(0.8, 1, 30);
y = [y1, y2, y3];

% Discretisation du temps sur une periode:
tmax  = 2*pi/omega;
t = linspace(0, tmax, 20);

umax = max(max(u(y, t'))); % pour borner les axes 
umin = min(min(u(y, t'))); % pour borner les axes 

fprintf('Faire Ctrl C pour arreter...\n');
while 1
  for n = 1:length(t)
    plot(u(y, t(n)), y,'r')
    hold on
    plot(zeros(size(y)), y,'k--') % axe x = 0
    plot([umin, umax], [0, 0],'k--') % axe y = 0
    plot([umin, umax], [1 1], 'k') % paroi sup
    plot([umin, umax], [1.01 1.01], 'k') % paroi sup
    plot([umin, umax], [-1 -1], 'k') % paroi inf
    plot([umin, umax], [-1.01 -1.01], 'k') % paroi inf
    axis([umin, umax, -1.2, 1.2]);
    title(['profil de vitesse a t = ' num2str(t(n))]);
    xlabel('u(y, t)');
    ylabel('y');
    drawnow;
    pause -1;
    hold off;
  end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function velocity = u(y, t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global omega;

tmp = cosh((1+i)*y*sqrt(omega))/ cosh((1+i)*sqrt(omega));
velocity = real(i/omega * exp(i*omega*t) * (1 - tmp));


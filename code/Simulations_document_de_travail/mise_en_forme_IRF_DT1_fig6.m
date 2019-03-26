%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MELEZE : A DSGE model for fiscal simulations in a monetary union
% Campagne B. & Poissonnier A., G2016/05, Insee.
%
%Programme de tracé des fonctions de réponse 
%des figures 6a et 6b du document de travail
%(partie 2 : mise en forme des graphiques)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tracé de la figure 6a : lancer jusqu'à la mention "Fin figure 6a"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all

ColorOdrCustom = lines(5);
ColorOdrCustom =ColorOdrCustom(2:5,:);
MyStyles = {'-';':';'--';'-.'};
      
name={'e_ug1'};
SIMNAME={'calib_CalibrationFR_EU','calib_CalibrationFR_EU_noEdgeworth','calib_CalibrationFR_EU_zeromu','calib_CalibrationFR_EU_zeromu_noEdgeworth'};
ll=30; % longueur de l'IRF
[m,n]=size(name);
[m2,n2]=size(SIMNAME);
    for k=1:n
        figure('Name',['IRF to ',name{k}]); hold on;
                for j=1:n2
                load (['.\SAVED_IRFS\IRF_',SIMNAME{j},'_stoch_EulerG_0_0_0_0'])
                plot(eval(['c1_',name{k},'(1:ll)']),'LineWidth',3,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
                end
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Baseline','non Ricardians only','Edgeworth only','neither', 'Location',myloc,'FontSize',14);
                set(gca, 'Ygrid', 'on','Xgrid', 'on','Fontsize',14);
    set(gcf,'PaperOrientation','landscape');
    set(gcf,'PaperPosition', [1 1 29.7 21]);
 saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FR_Ric_Edgeworth',name{k}], 'png');
 saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FR_Ric_Edgeworth',name{k}], 'psc');
    end
%    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fin figure 6a
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tracé de la figure 6b : lancer jusqu'à la mention "Fin figure 6b"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ColorOdrCustom = lines(5);
ColorOdrCustom =ColorOdrCustom(2:5,:);
MyStyles = {'-';':';'--';'-.'};
      
name={'e_ug1'};
SIMNAME={'calib_CalibrationFR_EU_sigmac05','calib_CalibrationFR_EU_sigmac05_noEdgeworth','calib_CalibrationFR_EU_sigmac05_zeromu','calib_CalibrationFR_EU_sigmac05_zeromu_noEdgeworth'};
ll=30; % longueur de l'IRF
[m,n]=size(name);
[m2,n2]=size(SIMNAME);
    for k=1:n
        figure('Name',['IRF to ',name{k}]); hold on;
                for j=1:n2
                load (['.\SAVED_IRFS\IRF_',SIMNAME{j},'_stoch_EulerG_0_0_0_0'])
                end
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Baseline','non Ricardians only','Edgeworth only','neither', 'Location',myloc,'FontSize',14);
                set(gca, 'Ygrid', 'on','Xgrid', 'on','Fontsize',14);
    set(gcf,'PaperOrientation','landscape');
    set(gcf,'PaperPosition', [1 1 29.7 21]);
 saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FR_Ric_Edgeworth_sigmac0,5',name{k}], 'png');
 saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FR_Ric_Edgeworth_sigmac0,5',name{k}], 'psc');
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fin figure 6b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MELEZE : A DSGE model for fiscal simulations in a monetary union
% Campagne B. & Poissonnier A., G2016/05, Insee.
%
%Programme de tracé des fonctions de réponse 
%des figures 7 à 14 du document de travail
%(partie 2 : mise en forme des graphiques)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Lancer tout le programme : les figures 7 à 14 sont tracées
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all

ColorOdrCustom = lines(5);
ColorOdrCustom =ColorOdrCustom(2:5,:);
MyStyles = {'-';':';'--';'-.'};
      
name={'e_prod1','e_pref1','e_um','e_ug1'};
SIMNAME={'EulerG_0_0_0_0','BRule_0,9_0_0_0,02','BRule_0,9_-0,01_0_0,02','BRule_0,9_0,04_0_0,02'};
ll=40 % longueur de l'IRF
[m,n]=size(name)
[m2,n2]=size(SIMNAME)
    for k=1:n
        figure('Name',['IRF to ',name{k}]); hold on;
                for j=1:n2
                load (['.\SAVED_IRFS\IRF_calib_CalibrationFR_EU_stoch_',SIMNAME{j}])
            h(1)=subplot(2,2,1);
                plot(eval(['y1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
            h(2)=subplot(2,2,2);
                plot(eval(['g1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
            h(3)=subplot(2,2,3);
                plot(eval(['r_',name{k},'(1:ll)'])-eval(['pie1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
            h(4)=subplot(2,2,4);
                plot(eval(['pa1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
                end
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Baseline','BR acyclic','BR procyclical','BR contracyclical', 'Location',myloc);
    title(h(1),'Output','Fontsize',12);
    title(h(2),'GG Cons.','Fontsize',12);
    title(h(3),'Real interest rate','Fontsize',12);
    title(h(4),'Public debt','Fontsize',12);
    set(h(1), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(2), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(3), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(4), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(gcf,'PaperOrientation','landscape');
    set(gcf,'PaperPosition', [1 1 29.7 21]);
 saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FR_EulerBR',name{k}], 'png');
 saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FR_EulerBR',name{k}], 'psc');
 
 figure('Name',['IRF to ',name{k}]); hold on;
                for j=1:n2
                load (['.\SAVED_IRFS\IRF_calib_CalibrationFR_EU_stoch_',SIMNAME{j}])
            h(1)=subplot(3,2,1);
                plot(eval(['c1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
            h(2)=subplot(3,2,2);
                plot(eval(['tb_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
            h(3)=subplot(3,2,3);
                 plot(eval(['L1_',name{k},'(1:ll)'])-eval(['pie1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
            h(4)=subplot(3,2,4);
                plot(eval(['rw1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;            
            h(5)=subplot(3,2,5);
                plot(eval(['I1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
            h(6)=subplot(3,2,6);
                plot(eval(['rk1_',name{k},'(1:ll)']),'LineWidth',2,'LineStyle',MyStyles{j},'color',ColorOdrCustom(j,:)); hold all;
                end
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Baseline','BR acyclic','BR procyclical','BR contracyclical', 'Location',myloc);
    title(h(1),'Cons.','Fontsize',12);
    title(h(2),'Trade balance','Fontsize',12);
    title(h(3),'Labour','Fontsize',12);
    title(h(4),'Real wage','Fontsize',12);
    title(h(5),'Inv.','Fontsize',12);
    title(h(6),'Cap. return','Fontsize',12);
    set(h(1), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(2), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(3), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(4), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(5), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(6), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(gcf,'PaperOrientation','portrait');
    set(gcf,'PaperPosition', [1 1 21 29.7]);
 saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FR_EulerBR2',name{k}], 'png');
 saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FR_EulerBR2',name{k}], 'psc');
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MELEZE : A DSGE model for fiscal simulations in a monetary union
% Campagne B. & Poissonnier A., G2016/05, Insee.
%
%Programme de tracé des fonctions de réponse 
%des figures 2 à 5 du document de travail
%(partie 2 : mise en forme des graphiques)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Lancer tout le programme : les figures 2 à 5 sont tracées
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all

load (['.\SAVED_IRFS\IRF_calib_CalibrationFR_EU_stoch_EulerG_0_0_0_0'])
name={'e_prod1','e_pref1','e_um','e_ug1'};
ll=40 % longueur de l'IRF
[m,n]=size(name)
    for i=1:n
        figure('Name',['IRF to ',name{i}]); hold on;
            h(1)=subplot(3,2,1); 
                plot(eval(['y1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle','-','Marker','o','markers',6); hold all;
                plot(eval(['y2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle','-','Marker','s','markers',6);
                plot(eval(['L1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle',':','Marker','x','markers',6);
                plot(eval(['L2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle',':','Marker','+','markers',6);
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Output (FR)','Output (Z€)','Labour (FR)','Labour (Z€)', 'Location',myloc);
            h(2)=subplot(3,2,2); 
                plot(eval(['r_',name{i},'(1:ll)']),'LineWidth',2,'Color','k','LineStyle','-','markers',6); hold all;
                plot(eval(['pietildec_',name{i},'(1:ll)']),'LineWidth',2,'Color','k','LineStyle',':','markers',6); 
                plot(eval(['pie1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle',':','Marker','o','markers',6); 
                plot(eval(['pie2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle',':','Marker','s','markers',6);
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Euribor (nominal)','Inflation (total-VAT included)','Inflation (FR)','Inflation (Z€)', 'Location',myloc);              
            h(3)=subplot(3,2,3);
                plot(eval(['c1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle','-','Marker','o','markers',6);hold all;
                plot(eval(['c2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle','-','Marker','s','markers',6);
                plot(eval(['I1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle',':','Marker','x','markers',6);
                plot(eval(['I2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle',':','Marker','+','markers',6);
                if strcmp(name{i},'e_ug1'); plot(eval(['g1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle','--','Marker','^','markers',6); end;
                if strcmp(name{i},'e_ug1'); plot(eval(['g2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle','--','Marker','v','markers',6); end;
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Cons. (FR)','Cons. (Z€)','Inv. (FR)','Inv. (Z€)','Cons. Gov. (FR)','Cons. Gov. (Z€)', 'Location',myloc);
            h(4)=subplot(3,2,4);
                plot(eval(['rw1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle','-','Marker','o','markers',6); hold all;
                plot(eval(['rw2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle','-','Marker','s','markers',6);
                plot(eval(['rk1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle',':','Marker','x','markers',6);
                plot(eval(['rk2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle',':','Marker','+','markers',6);
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Real wage (FR)','Real wage (Z€)','Cap. return (FR)','Cap. return (Z€)', 'Location',myloc);
            h(5)=subplot(3,2,5); 
                plot(eval(['tb_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle','-','markers',6);hold all;
                plot(eval(['t_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle',':','markers',6);
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'Trade Balance (FR)','Terms of trade (PZ€/PFR)', 'Location',myloc);
            h(6)=subplot(3,2,6);
                plot(eval(['fa1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle','-','Marker','o','markers',6); hold all;
                plot(eval(['fa2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle','-','Marker','s','markers',6);
                plot(eval(['pa1_',name{i},'(1:ll)']),'LineWidth',1,'Color','b','LineStyle',':','Marker','x','markers',6);
                plot(eval(['pa2_',name{i},'(1:ll)']),'LineWidth',1,'Color','r','LineStyle',':','Marker','+','markers',6);
                temp=ylim;
                if abs(temp(1))>temp(2); myloc='SouthEast'; else myloc='NorthEast'; end
                legend(gca,'HH Assets (FR)','HH Assets  (Z€)','Public Debt (FR)','Public Debt (Z€)', 'Location',myloc);      
    title(h(1),'Real activity','Fontsize',12);
    title(h(2),'Nominal developments','Fontsize',12); 
    title(h(3),'Final demand','Fontsize',12); 
    title(h(4),'Prod. factor cost','Fontsize',12); 
    title(h(5),'Open economy','Fontsize',12);
    title(h(6),'Financial assets/debts','Fontsize',12); 
    set(h(1), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(2), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(3), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(4), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(5), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(h(6), 'Ygrid', 'on','Xgrid', 'on','Fontsize',10);
    set(gcf,'PaperOrientation','portrait');
    set(gcf,'PaperPosition', [1 1 21 29.7]);
saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FRstandard',name{i}], 'png');
saveas(gcf , ['.\SAVED_IRFS\IRF_DT1_FRstandard',name{i}], 'psc');

    end
    

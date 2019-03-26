////////////////////////////////////////////////////////////////////
//MELEZE:A DSGE model for fiscal simulations in a monetary union
//Campagne B. & Poissonnier A.		     
//Insee Working Paper G2016/05
//
//Programme de simulation manuelle du modèle
//
////////////////////////////////////////////////////////////////////

// déclaration des variables du modèle
@#include ".\SAVED_Inputs\meleze_variables(block).mod"
// calibration
@#include ".\SAVED_Inputs\calib_CalibrationFR_EU.txt"

// choix du comportement du gouvernement (EULERGOV) :
//    si 0 : règle budgétaire et fiscale (cf. partie 2.4.1 du document de travail)
//    si 1 : gouvernement optimisateur (cf. partie 2.4.2 du document de travail)
@#define EULERGOV = 1 
// caractéristiques de la règle budgétaire et fiscale lorsque EULERGOV = 0 
// cf. équation LIN.25 de l'annexe B du document de travail :
BRar= 0.8;
BRcycle= 0;
BRrr= 0;
BRdef= 0.02;

// choix des variables de dépenses et recettes publiques :
//  - exogénéité des dépenses publiques (DUMMIES = 1 si exogènes, 0 si endogènes)
//  - existence de transferts aux ménages (PHIRULE = 1 si transferts, 0 si absence de transferts)
//  - existence de taxes (NOTAX = 1 si taxes, 0 si absence de taxes)
@#define DUMMIES = 0 
@#define PHIRULE = 0
@#define NOTAX = 0

// équations du modèle
@#include ".\SAVED_Inputs\meleze_model(block).mod"

// ajouter les commandes souhaitées ci dessous.
steady;
check;

// chocs simulés : décocher selon le choix ou bien ajouter manuellement le choc voulu
shocks; 
var e_um ;
 stderr 1.000000000000e+000 ;
//var e_prod1 ;
// stderr 1.000000000000e+000 ;
//var e_pref1 ;
// stderr 1.000000000000e+000 ;
//var e_inv1 ;
// stderr 1.000000000000e+000 ;
//var e_ug1 ;
// stderr 1.000000000000e+000 ;
//var e_w1 ;
// stderr 1.000000000000e+000 ;
//var e_c1 ;
// stderr 1.000000000000e+000 ;
//var e_d1 ;
// stderr 1.000000000000e+000 ;
//var e_fd1 ;
// stderr 1.000000000000e+000 ;
//var e_k1 ;
// stderr 1.000000000000e+000 ;
//var e_ktot1 ;
// stderr 1.000000000000e+000 ;
//var e_phi1 ;
// stderr 1.000000000000e+000 ;
//var e_phinr1 ;
// stderr 1.000000000000e+000 ;
//var e_phir1 ;
// stderr 1.000000000000e+000 ;
end; 

stoch_simul(periods=500, irf = 100); 

close all;


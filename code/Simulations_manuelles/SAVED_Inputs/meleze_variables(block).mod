////////////////////////////////////////////////////////////////////
//MELEZE:A DSGE model for fiscal simulations in a monetary union
//Campagne B. & Poissonnier A.		     
//Insee Working Paper G2016/05
//
//Déclaration des variables du modèle
//
////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
//Endogenous variables
var y1 y2 													//Outputs
c1 c2 cr1 cr2 cnr1 cnr2 								//Aggregate consumption, Ricardians and non Ricardians
ch1 cf1 cf2 ch2 										//Consumption by product
Ih1 Ih2 If1 If2 										//Investment by product
d1 d2 fd1 fd2 											//Dividends
rmc1 rmc2 												//Real marginal costs
rw1 rw2 rwr1 rwr2 rwnr1 rwnr2 							//Real wages
L1 L2 Lnr1 Lnr2 Lr1 Lr2 								//Labour supplies
K1 K2 rk1 rk2 I1 I2 q1 q2								//Investment, capital and cost
fa1 fa2 pa1 pa2 										//Financial Assets
pie1 pie2 piec1 piec2 									//Inflation
gd1 gd2 g1 g2 											//Government expenditures
nuk1 nuk2 nuc1 nuc2 nuw1 nuw2 nud1 nud2 nufd1 nufd2 	//Tax levels
phi1 phi2 phir1 phir2 phinr1 phinr2 					//Transfers
phidnr1 phidnr2 phidr1 phidr2
rpc1 rpc2 												//Relative price of consumption
t 														//Terms of trade
y pietildec r 											//Central bank
um ug1 ug2 uc1 uc2 uw1 uw2 								//AR shocks
ud1 ud2 ufd1 ufd2 uk1 uk2 uktot1 uktot2 		
uprod1 uprod2 upref1 upref2 uinv1 uinv2 
uphi1 uphi2 uphinr1 uphinr2 uphir1 uphir2
tb                                                      //Trade balance
Ur1 Ur2 Unr1 Unr2                                       //Utility
Urc1 Urc2 Unrc1 Unrc2  
Urg1 Urg2 Unrg1 Unrg2  
Url1 Url2 Unrl1 Unrl2  
;

//Exogenous shocks (25)
varexo e_um 											//Monetary
e_prod1 e_prod2 e_pref1 e_pref2 e_inv1 e_inv2			//Structural
e_ug1 e_ug2 e_w1 e_w2 e_c1 e_c2 						//Fiscal instruments
e_d1 e_d2 e_fd1 e_fd2 e_k1 e_k2 e_ktot1 e_ktot2 		
e_phi1 e_phi2 e_phinr1 e_phinr2	 e_phir1 e_phir2		//Shocks on transfers
e_dummyBR e_dummyTR 									//Dummies to shut down Budget Rule or/and Taylor Rule
;

//Structural parameters
//113 parameters
parameters 
g // exogenous growth
alpha1 alpha2
kappa1 kappa2
alpha theta thetafa
sigmac1 sigmac2 sigmal1 sigmal2
eta1 eta2
beta1 betag1 beta2 betag2
beta1tilde betag1tilde beta2tilde betag2tilde
delta
hc1 hc2 hg1 hg2 hl1 hl2
xiw1 xiw2 xi1 xi2
gamma1 gamma2 gammaw1 gammaw2
theta1 theta2 thetaw1 thetaw2
rbar rho rpi ry
piec1bar piec2bar pie1bar pie2bar
tbar rpc1bar rpc2bar
cy1bar cy2bar gy1bar gy2bar iy1bar iy2bar tbbar
fa1bar fa2bar pa1bar pa2bar
fd1bar fd2bar d1bar d2bar
nuc1bar nuc2bar nuw1bar nuw2bar nuk1bar nuk2bar nud1bar nud2bar nufd1bar nufd2bar
phi1bar phi2bar phir1bar phir2bar phinr1bar phinr2bar
psifa1bar psifa2bar psigpa1bar psigpa2bar psiprimefa1bar psiprimefa2bar psigprimepa1bar psigprimepa2bar psigprimeprimepa1bar psigprimeprimepa2bar
rk1bar rk2bar
sc1 sc2 sw1 sw2 mu1 mu2 
arr S
Br1bar Br2bar Bnr1bar Bnr2bar
deltaOmega1bar deltaOmega2bar
BRcycle BRrr BRdef BRar	
edgeworth

//Additional endogenous levels
// not necessary to run the code but to compute other things ex-post
y1bar y2bar
c1bar c2bar cr1bar cr2bar cnr1bar cnr2bar
ch1bar cf1bar cf2bar ch2bar
Ih1bar Ih2bar If1bar If2bar
rmc1bar rmc2bar
rw1bar rw2bar rwr1bar rwr2bar rwnr1bar rwnr2bar
L1bar L2bar Lnr1bar Lnr2bar Lr1bar Lr2bar
K1bar K2bar I1bar I2bar q1bar q2bar
g1bar g2bar
ybar pietildecbar
Urc1bar Urc2bar Unrc1bar Unrc2bar
Url1bar Url2bar Unrl1bar Unrl2bar
Urg1bar Urg2bar Unrg1bar Unrg2bar
;


 

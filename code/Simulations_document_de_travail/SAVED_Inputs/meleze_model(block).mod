////////////////////////////////////////////////////////////////////
//MELEZE:A DSGE model for fiscal simulations in a monetary union
//Campagne B. & Poissonnier A.		     
//Insee Working Paper G2016/05
//
//Equations du modèle
//
//NB : la numérotation "LIN.x" correspond 
//à celle de l'annxe B du document de travail
////////////////////////////////////////////////////////////////////

@#if DUMMIES
	model;
@#else
	model(linear);
@#endif

	//Goods aggregation  eq LIN.1 to LIN.4
		ch1 = c1+alpha1*t; 
		cf1 = c1+(alpha1-1)*t; 
		cf2 = c2+(1-alpha2)*t; 
		ch2 = c2-alpha2*t; 

	//Investment aggregation  eq LIN.5 to LIN.8
		Ih1 = I1+alpha1*t;
		If1 = I1+(alpha1-1)*t;
		If2 = I2+(1-alpha2)*t;
		Ih2 = I2-alpha2*t;
    
	//Production clearing  eq LIN.19 LIN.20
		y1 = (1-alpha)*uprod1+(1-alpha)*L1+alpha*K1(-1);
		y2 = (1-alpha)*uprod2+(1-alpha)*L2+alpha*K2(-1);	
	
  //Demands clearing  eq LIN.37 LIN.38
		y1*theta = (1-alpha1)*cy1bar*tbar^alpha1*theta*ch1 +alpha2*cy2bar*tbar^(1-alpha2)*cf2       +gy1bar*theta*g1 +(1-alpha1)*theta*iy1bar*tbar^alpha1*Ih1 +alpha2*iy2bar*tbar^(1-alpha2)*If2;
	  y2       = (1-alpha2)*cy2bar*tbar^(-alpha2)*ch2    +alpha1*cy1bar*tbar^(alpha1-1)*theta*cf1 +gy2bar*g2       +(1-alpha2)*iy2bar*tbar^(-alpha2)*Ih2    +alpha1*iy1bar*tbar^(alpha1-1)*theta*If1;
	
	//Ricardian and non Ricardian aggregation  eq LIN.14 LIN.15 LIN.16 
   	c1 = sc1*cnr1+(1-sc1)*cr1;
		c2 = sc2*cnr2+(1-sc2)*cr2;
		rw1 = sw1*rwnr1+(1-sw1)*rwr1;
		rw2 = sw2*rwnr2+(1-sw2)*rwr2;
		L1 = sw1*Lnr1+(1-sw1)*Lr1;
		L2 = sw2*Lnr2+(1-sw2)*Lr2;
		
		@#if NONRICARDIAN 
			Lnr1 = L1-thetaw1*(rwnr1-rw1);
			Lnr2 = L2-thetaw2*(rwnr2-rw2);
		@#else
			Lnr1 = 0;
			Lnr2 = 0;
		@#endif
	
	//Dividends
		// real sector dividends  eq LIN.22
		d1 = y1-(theta1-1)*rmc1;
		d2 = y2-(theta2-1)*rmc2;

		// with real marginal cost  eq LIN.23
		rmc1 = rpc1 + (1-alpha)*(- uprod1+rw1+nuc1bar/(1+nuc1bar)*nuc1+nuw1bar/(1+nuw1bar)*nuw1)+alpha*rk1;
		rmc2 = rpc2 + (1-alpha)*(- uprod2+rw2+nuc2bar/(1+nuc2bar)*nuc2+nuw2bar/(1+nuw2bar)*nuw2)+alpha*rk2;
		
		// financial dividends  eq LIN.26 LIN.27
		theta*fd1bar*pie1bar*(1+g)*(fd1+pie1) = thetafa/(1+thetafa)*(theta*(psiprimefa1bar*fa1bar^2+fa1bar*psifa1bar)*fa1(-1)+theta*(psigprimepa1bar*pa1bar^2+pa1bar*psigpa1bar)*pa1(-1)+       tbar*((psiprimefa2bar*fa2bar^2+fa2bar*psifa2bar)*fa2(-1)+(psigprimepa2bar*pa2bar^2+pa2bar*psigpa2bar)*pa2(-1)+t(-1)*(psifa2bar*fa2bar+psigpa2bar*pa2bar)));
		      fd2bar*pie2bar*(1+g)*(fd2+pie2) =       1/(1+thetafa)*(      (psiprimefa2bar*fa2bar^2+fa2bar*psifa2bar)*fa2(-1)+      (psigprimepa2bar*pa2bar^2+pa2bar*psigpa2bar)*pa2(-1)+ theta/tbar*((psiprimefa1bar*fa1bar^2+fa1bar*psifa1bar)*fa1(-1)+(psigprimepa1bar*pa1bar^2+pa1bar*psigpa1bar)*pa1(-1)-t(-1)*(psifa1bar*fa1bar+psigpa1bar*pa1bar)));
 	
	//Euler equations for consumption  eq LIN.9
		0 = (1-(1-sigmac1)*(1-eta1))*(cr1(+1)-cr1)+hc1*(1-sigmac1)*(1-eta1)*(c1-c1(-1))-(1-sigmac1)*eta1*(g1(+1)-g1)*edgeworth+hg1*(1-sigmac1)*eta1*(g1-g1(-1))*edgeworth+(1+sigmal1)*sigmac1*Br1bar*((Lr1(+1)-Lr1)-hl1*(L1-L1(-1)))+piec1(+1)+nuc1bar/(1+nuc1bar)*(nuc1(+1)-nuc1)-1/(rbar-psifa1bar)*(rbar*r-psiprimefa1bar*fa1bar*fa1)-upref1;
		0 = (1-(1-sigmac2)*(1-eta2))*(cr2(+1)-cr2)+hc2*(1-sigmac2)*(1-eta2)*(c2-c2(-1))-(1-sigmac2)*eta2*(g2(+1)-g2)*edgeworth+hg2*(1-sigmac2)*eta2*(g2-g2(-1))*edgeworth+(1+sigmal2)*sigmac2*Br2bar*((Lr2(+1)-Lr2)-hl2*(L2-L2(-1)))+piec2(+1)+nuc2bar/(1+nuc2bar)*(nuc2(+1)-nuc2)-1/(rbar-psifa2bar)*(rbar*r-psiprimefa2bar*fa2bar*fa2)-upref2;
	
	// Euler on public spending or Budget Rule  eq LIN.24 or LIN.25
		@#if EULERGOV
			@#if DUMMIES
				//ATTENTION DUMMY
				0 = (1-e_dummyBR)*((1-betag1tilde*hg1)*(betag1tilde/pie1bar*(rbar*r-(2*psigprimepa1bar+psigprimeprimepa1bar*pa1bar)*pa1bar*pa1)-pie1(+1)-gd1(+1)+gd1)+(1-sigmac1)*eta1*((1+betag1tilde*hg1^2)*(gd1(+1)-gd1)-betag1tilde*hg1*(gd1(+2)-gd1(+1))-hg1*(gd1-gd1(-1)))+edgeworth*((1-sigmac1)*(1-eta1)*hc1*(betag1tilde*(c1(+1)-c1)-c1+c1(-1))+(1-sigmac1)*(1-eta1)*(deltaOmega1bar*(cr1(+1)-cr1)+(1-deltaOmega1bar)*(cnr1(+1)-cnr1)-betag1tilde*hg1*(deltaOmega1bar*(cr1(+2)-cr1(+1))+(1-deltaOmega1bar)*(cnr1(+2)-cnr1(+1))))-sigmac1*(1+sigmal1)*deltaOmega1bar*Br1bar*(Lr1(+1)-Lr1-hl1*(L1-L1(-1))-betag1tilde*hg1*((Lr1(+2)-Lr1(+1))-hl1*(L1(+1)-L1)))+sigmac1*(1+sigmal1)*(1-deltaOmega1bar)*Bnr1bar*(Lnr1(+1)-Lnr1-hl1*(L1-L1(-1))-betag1tilde*hg1*((Lnr1(+2)-Lnr1(+1))-hl1*(L1(+1)-L1)))))+e_dummyBR*gd1;
				0 = (1-e_dummyBR)*((1-betag2tilde*hg2)*(betag2tilde/pie2bar*(rbar*r-(2*psigprimepa2bar+psigprimeprimepa2bar*pa2bar)*pa2bar*pa2)-pie2(+1)-gd2(+1)+gd2)+(1-sigmac2)*eta2*((1+betag2tilde*hg2^2)*(gd2(+1)-gd2)-betag2tilde*hg2*(gd2(+2)-gd2(+1))-hg2*(gd2-gd2(-1)))+edgeworth*((1-sigmac2)*(1-eta2)*hc2*(betag2tilde*(c2(+1)-c2)-c2+c2(-1))+(1-sigmac2)*(1-eta2)*(deltaOmega2bar*(cr2(+1)-cr2)+(1-deltaOmega2bar)*(cnr2(+1)-cnr2)-betag2tilde*hg2*(deltaOmega2bar*(cr2(+2)-cr2(+1))+(1-deltaOmega2bar)*(cnr2(+2)-cnr2(+1))))-sigmac2*(1+sigmal2)*deltaOmega2bar*Br2bar*(Lr2(+1)-Lr2-hl2*(L2-L2(-1))-betag2tilde*hg2*((Lr2(+2)-Lr2(+1))-hl2*(L2(+1)-L2)))+sigmac2*(1+sigmal2)*(1-deltaOmega2bar)*Bnr2bar*(Lnr2(+1)-Lnr2-hl2*(L2-L2(-1))-betag2tilde*hg2*((Lnr2(+2)-Lnr2(+1))-hl2*(L2(+1)-L2)))))+e_dummyBR*gd2;

			@#else
				//Government spending (Euler) 
				0 = (1-betag1tilde*hg1)*(betag1tilde/pie1bar*(rbar*r-(2*psigprimepa1bar+psigprimeprimepa1bar*pa1bar)*pa1bar*pa1)-pie1(+1)-gd1(+1)+gd1)+(1-sigmac1)*eta1*((1+betag1tilde*hg1^2)*(gd1(+1)-gd1)-betag1tilde*hg1*(gd1(+2)-gd1(+1))-hg1*(gd1-gd1(-1)))+edgeworth*((1-sigmac1)*(1-eta1)*hc1*(betag1tilde*hg1*(c1(+1)-c1)-c1+c1(-1))+(1-sigmac1)*(1-eta1)*(deltaOmega1bar*(cr1(+1)-cr1)+(1-deltaOmega1bar)*(cnr1(+1)-cnr1)-betag1tilde*hg1*(deltaOmega1bar*(cr1(+2)-cr1(+1))+(1-deltaOmega1bar)*(cnr1(+2)-cnr1(+1))))-sigmac1*(1+sigmal1)*deltaOmega1bar*Br1bar*(Lr1(+1)-Lr1-hl1*(L1-L1(-1))-betag1tilde*hg1*((Lr1(+2)-Lr1(+1))-hl1*(L1(+1)-L1)))-sigmac1*(1+sigmal1)*(1-deltaOmega1bar)*Bnr1bar*(Lnr1(+1)-Lnr1-hl1*(L1-L1(-1))-betag1tilde*hg1*((Lnr1(+2)-Lnr1(+1))-hl1*(L1(+1)-L1))));
				0 = (1-betag2tilde*hg2)*(betag2tilde/pie2bar*(rbar*r-(2*psigprimepa2bar+psigprimeprimepa2bar*pa2bar)*pa2bar*pa2)-pie2(+1)-gd2(+1)+gd2)+(1-sigmac2)*eta2*((1+betag2tilde*hg2^2)*(gd2(+1)-gd2)-betag2tilde*hg2*(gd2(+2)-gd2(+1))-hg2*(gd2-gd2(-1)))+edgeworth*((1-sigmac2)*(1-eta2)*hc2*(betag2tilde*hg2*(c2(+1)-c2)-c2+c2(-1))+(1-sigmac2)*(1-eta2)*(deltaOmega2bar*(cr2(+1)-cr2)+(1-deltaOmega2bar)*(cnr2(+1)-cnr2)-betag2tilde*hg2*(deltaOmega2bar*(cr2(+2)-cr2(+1))+(1-deltaOmega2bar)*(cnr2(+2)-cnr2(+1))))-sigmac2*(1+sigmal2)*deltaOmega2bar*Br2bar*(Lr2(+1)-Lr2-hl2*(L2-L2(-1))-betag2tilde*hg2*((Lr2(+2)-Lr2(+1))-hl2*(L2(+1)-L2)))-sigmac2*(1+sigmal2)*(1-deltaOmega2bar)*Bnr2bar*(Lnr2(+1)-Lnr2-hl2*(L2-L2(-1))-betag2tilde*hg2*((Lnr2(+2)-Lnr2(+1))-hl2*(L2(+1)-L2))));
 			@#endif
		@#else
			// Budget Rules
			@#if DUMMIES
				//ATTENTION DUMMY   
				gd1 = (1-e_dummyBR)*(BRar*gd1(-1) +BRcycle/gy1bar*y1(-1) + BRrr*(betag1/pie1bar*rbar*r(-1)-pie1)+BRdef*pa1bar/gy1bar*pa1(-1)); 
				gd2 = (1-e_dummyBR)*(BRar*gd2(-1) +BRcycle/gy2bar*y2(-1) + BRrr*(betag2/pie2bar*rbar*r(-1)-pie2)+BRdef*pa2bar/gy2bar*pa2(-1)); 
			@#else
				gd1 = BRar*gd1(-1) +BRcycle/gy1bar*y1(-1) + BRrr*(betag1/pie1bar*rbar*r(-1)-pie1)+BRdef*pa1bar/gy1bar*pa1(-1); 
				gd2 = BRar*gd2(-1) +BRcycle/gy2bar*y2(-1) + BRrr*(betag2/pie2bar*rbar*r(-1)-pie2)+BRdef*pa2bar/gy2bar*pa2(-1); 
			@#endif   
		@#endif   
     
	//Tobin's q  eq LIN.11 
		q1 = ((1-sigmac1)*(1-eta1)-1)*(cr1(+1)-cr1)-hc1*(1-sigmac1)*(1-eta1)*(c1-c1(-1))
		+(1-sigmac1)*eta1*(g1(+1)-g1)*edgeworth-hg1*(1-sigmac1)*eta1*(g1-g1(-1))*edgeworth-(1+sigmal1)*sigmac1*Br1bar*((Lr1(+1)-Lr1)-hl1*(L1-L1(-1)))+(1-delta)*beta1tilde*q1(+1)+beta1tilde*rk1bar*(1-nuk1bar)/(1+nuc1bar)*(rk1(+1)-nuc1bar/(1+nuc1bar)*nuc1(+1)-nuk1bar/(1-nuk1bar)*nuk1(+1))+upref1;
		q2 = ((1-sigmac2)*(1-eta2)-1)*(cr2(+1)-cr2)-hc2*(1-sigmac2)*(1-eta2)*(c2-c2(-1))
		+(1-sigmac2)*eta2*(g2(+1)-g2)*edgeworth-hg2*(1-sigmac2)*eta2*(g2-g2(-1))*edgeworth-(1+sigmal2)*sigmac2*Br2bar*((Lr2(+1)-Lr2)-hl2*(L2-L2(-1)))+(1-delta)*beta2tilde*q2(+1)+beta2tilde*rk2bar*(1-nuk2bar)/(1+nuc2bar)*(rk2(+1)-nuc2bar/(1+nuc2bar)*nuc2(+1)-nuk2bar/(1-nuk2bar)*nuk2(+1))+upref2;
	//Investment decision  eq LIN.10
		0=q1+uinv1-S*(1+g)^2*(I1-I1(-1)-beta1tilde*(1+g)*(I1(+1)-I1));
		0=q2+uinv2-S*(1+g)^2*(I2-I2(-1)-beta2tilde*(1+g)*(I2(+1)-I2));
	
	//Capital dynamics  eq LIN.12
		(1+g)*K1 = (1-delta)*K1(-1)+(g+delta)*(I1+uinv1);
		(1+g)*K2 = (1-delta)*K2(-1)+(g+delta)*(I2+uinv2);
		
	//Capital and labour arbitrage  eq LIN.21
		rk1+K1(-1)= rw1 + nuc1bar/(1+nuc1bar)*nuc1+nuw1bar/(1+nuw1bar)*nuw1+L1;
		rk2+K2(-1)= rw2 + nuc2bar/(1+nuc2bar)*nuc2+nuw2bar/(1+nuw2bar)*nuw2+L2;
		
	//Asset dynamics  eq LIN.39 LIN.41
		//fa1bar*fa1 = (fa1bar/(beta1tilde*(1+g)))*(rbar/(rbar-psifa1bar)*r(-1)+(1-psiprimefa1bar*fa1bar/(rbar-psifa1bar))*fa1(-1)-pie1)+(1-sw1)*(1-alpha)/(1+nuw1bar)*(theta1-1)/theta1*(rpc1+nuc1bar/(1+nuc1bar)*nuc1+rwr1+Lr1)-(1+nuc1bar)*rpc1bar*cy1bar*(1-sc1)*(rpc1+nuc1bar/(1+nuc1bar)*nuc1+cr1)-(1+nuc1bar)*rpc1bar*iy1bar*(rpc1+nuc1bar/(1+nuc1bar)*nuc1+I1)+phir1bar*phir1+(1-nud1bar)/theta1*(d1-nud1bar/(1-nud1bar)*nud1)+(1-nufd1bar)*fd1bar*(fd1-nufd1bar/(1-nufd1bar)*nufd1)+(1-nuk1bar)*alpha*(theta1-1)/theta1*(rpc1+rk1+K1(-1)-nuk1bar/(1-nuk1bar)*nuk1);
		fa2bar*fa2 = (fa2bar/(beta2tilde*(1+g)))*(rbar/(rbar-psifa2bar)*r(-1)+(1-psiprimefa2bar*fa2bar/(rbar-psifa2bar))*fa2(-1)-pie2)+(1-sw2)*(1-alpha)/(1+nuw2bar)*(theta2-1)/theta2*(rpc2+nuc2bar/(1+nuc2bar)*nuc2+rwr2+Lr2)-(1+nuc2bar)*rpc2bar*cy2bar*(1-sc2)*(rpc2+nuc2bar/(1+nuc2bar)*nuc2+cr2)-(1+nuc2bar)*rpc2bar*iy2bar*(rpc2+nuc2bar/(1+nuc2bar)*nuc2+I2)+phir2bar*phir2+(1-nud2bar)/theta2*(d2-nud2bar/(1-nud2bar)*nud2)+(1-nufd2bar)*fd2bar*(fd2-nufd2bar/(1-nufd2bar)*nufd2)+(1-nuk2bar)*alpha*(theta2-1)/theta2*(rpc2+rk2+K2(-1)-nuk2bar/(1-nuk2bar)*nuk2);
		
		//pa1bar*pa1 = pa1bar*(1/(betag1tilde*(1+g))+psigprimepa1bar*pa1bar/(pie1bar*(1+g)))*(rbar/(rbar-psigpa1bar)*r(-1)-pie1+(1-psigprimepa1bar*pa1bar/(rbar-psigpa1bar))*pa1(-1))+nud1bar/theta1*(nud1+d1)+fd1bar*nufd1bar*(nufd1+fd1)-gy1bar*g1-phi1bar*phi1+((theta1-1)/theta1*nuw1bar/(1+nuw1bar)*(1-alpha)+nuc1bar*(iy1bar+cy1bar)*rpc1bar+(theta1-1)/theta1*nuk1bar*alpha)*rpc1+(theta1-1)/theta1*nuw1bar/(1+nuw1bar)*(1-alpha)*(rw1+L1+nuw1+nuc1bar/(1+nuc1bar)*nuc1)+nuc1bar*cy1bar*rpc1bar*(c1+nuc1)+nuc1bar*iy1bar*rpc1bar*(I1+nuc1)+(theta1-1)/theta1*nuk1bar*alpha*(K1(-1)+nuk1+rk1);
		//pa2bar*pa2 = pa2bar*(1/(betag2tilde*(1+g))+psigprimepa2bar*pa2bar/(pie2bar*(1+g)))*(rbar/(rbar-psigpa2bar)*r(-1)-pie2+(1-psigprimepa2bar*pa2bar/(rbar-psigpa2bar))*pa2(-1))+nud2bar/theta2*(nud2+d2)+fd2bar*nufd2bar*(nufd2+fd2)-gy2bar*g2-phi2bar*phi2+((theta2-1)/theta2*nuw2bar/(1+nuw2bar)*(1-alpha)+nuc2bar*(iy2bar+cy2bar)*rpc2bar+(theta2-1)/theta2*nuk2bar*alpha)*rpc2+(theta2-1)/theta2*nuw2bar/(1+nuw2bar)*(1-alpha)*(rw2+L2+nuw2+nuc2bar/(1+nuc2bar)*nuc2)+nuc2bar*cy2bar*rpc2bar*(c2+nuc2)+nuc2bar*iy2bar*rpc2bar*(I2+nuc2)+(theta2-1)/theta2*nuk2bar*alpha*(K2(-1)+nuk2+rk2);
    pa1bar*pa1 = pa1bar*((rbar-psigpa1bar)/(pie1bar*(1+g)))*(rbar/(rbar-psigpa1bar)*r(-1)-pie1+(1-psigprimepa1bar*pa1bar/(rbar-psigpa1bar))*pa1(-1))+nud1bar/theta1*(nud1+d1)+fd1bar*nufd1bar*(nufd1+fd1)-gy1bar*g1-phi1bar*phi1+((theta1-1)/theta1*nuw1bar/(1+nuw1bar)*(1-alpha)+nuc1bar*(iy1bar+cy1bar)*rpc1bar+(theta1-1)/theta1*nuk1bar*alpha)*rpc1+(theta1-1)/theta1*nuw1bar/(1+nuw1bar)*(1-alpha)*(rw1+L1+nuw1+nuc1bar/(1+nuc1bar)*nuc1)+nuc1bar*cy1bar*rpc1bar*(c1+nuc1)+nuc1bar*iy1bar*rpc1bar*(I1+nuc1)+(theta1-1)/theta1*nuk1bar*alpha*(K1(-1)+nuk1+rk1);
		pa2bar*pa2 = pa2bar*((rbar-psigpa1bar)/(pie2bar*(1+g)))*(rbar/(rbar-psigpa2bar)*r(-1)-pie2+(1-psigprimepa2bar*pa2bar/(rbar-psigpa2bar))*pa2(-1))+nud2bar/theta2*(nud2+d2)+fd2bar*nufd2bar*(nufd2+fd2)-gy2bar*g2-phi2bar*phi2+((theta2-1)/theta2*nuw2bar/(1+nuw2bar)*(1-alpha)+nuc2bar*(iy2bar+cy2bar)*rpc2bar+(theta2-1)/theta2*nuk2bar*alpha)*rpc2+(theta2-1)/theta2*nuw2bar/(1+nuw2bar)*(1-alpha)*(rw2+L2+nuw2+nuc2bar/(1+nuc2bar)*nuc2)+nuc2bar*cy2bar*rpc2bar*(c2+nuc2)+nuc2bar*iy2bar*rpc2bar*(I2+nuc2)+(theta2-1)/theta2*nuk2bar*alpha*(K2(-1)+nuk2+rk2);

	//Zero cash needs condition	 eq LIN.28	 	
		0 = theta*fa1bar*fa1+theta*pa1bar*pa1+tbar*fa2bar*(t+fa2)+tbar*pa2bar*(t+pa2);
	
	//Non-Ricardian budget constraint  eq LIN.40
		@#if NONRICARDIAN
			cnr1 = (1-phinr1bar/((1+nuc1bar)*cy1bar*rpc1bar*sc1))*(rwnr1+Lnr1)+phinr1bar/((1+nuc1bar)*cy1bar*rpc1bar*sc1)*(phinr1-rpc1-nuc1bar/(1+nuc1bar)*nuc1);
			cnr2 = (1-phinr2bar/((1+nuc2bar)*cy2bar*rpc2bar*sc2))*(rwnr2+Lnr2)+phinr2bar/((1+nuc2bar)*cy2bar*rpc2bar*sc2)*(phinr2-rpc2-nuc2bar/(1+nuc2bar)*nuc2);
		@#else
			cnr1 = 0;
			cnr2 = 0;
		@#endif
	
	//Wage Phillips curve and wage setting  eq LIN.43 LIN.44
		xiw1*(rwr1-rwr1(-1)+piec1-gammaw1*piec1(-1)+(nuc1-nuc1(-1))*nuc1bar/(1+nuc1bar)) = xiw1*beta1tilde*(1+g)*(rwr1(+1)-rwr1+piec1(+1)-gammaw1*piec1+(nuc1(+1)-nuc1)*nuc1bar/(1+nuc1bar))+(1-xiw1)*(1-beta1tilde*(1+g)*xiw1)/(1+thetaw1*((1+sigmal1)*(1+Br1bar)-1))*(-rwr1-Lr1+(1+sigmal1)*(1+Br1bar)*(Lr1-hl1*L1(-1))+cr1);
		
		xiw2*(rwr2-rwr2(-1)+piec2-gammaw2*piec2(-1)+(nuc2-nuc2(-1))*nuc2bar/(1+nuc2bar)) = xiw2*beta2tilde*(1+g)*(rwr2(+1)-rwr2+piec2(+1)-gammaw2*piec2+(nuc2(+1)-nuc2)*nuc2bar/(1+nuc2bar))+(1-xiw2)*(1-beta2tilde*(1+g)*xiw2)/(1+thetaw2*((1+sigmal2)*(1+Br2bar)-1))*(-rwr2-Lr2+(1+sigmal2)*(1+Br2bar)*(Lr2-hl2*L2(-1))+cr2);
		
		@#if NONRICARDIAN 
			xiw1*(rwnr1-rwnr1(-1)+piec1-gammaw1*piec1(-1)+(nuc1-nuc1(-1))*nuc1bar/(1+nuc1bar)) = xiw1*beta1tilde*(1+g)*(rwnr1(+1)-rwnr1+piec1(+1)-gammaw1*piec1+(nuc1(+1)-nuc1)*nuc1bar/(1+nuc1bar))+(1-xiw1)*(1-beta1tilde*(1+g)*xiw1)/(1+thetaw1*((1+sigmal1)*(1+Bnr1bar)-1))*(-rwnr1-Lnr1+(1+sigmal1)*(1+Bnr1bar)*(Lnr1-hl1*L1(-1))+cnr1);
			xiw2*(rwnr2-rwnr2(-1)+piec2-gammaw2*piec2(-1)+(nuc2-nuc2(-1))*nuc2bar/(1+nuc2bar)) = xiw2*beta2tilde*(1+g)*(rwnr2(+1)-rwnr2+piec2(+1)-gammaw2*piec2+(nuc2(+1)-nuc2)*nuc2bar/(1+nuc2bar))+(1-xiw2)*(1-beta2tilde*(1+g)*xiw2)/(1+thetaw2*((1+sigmal2)*(1+Bnr2bar)-1))*(-rwnr2-Lnr2+(1+sigmal2)*(1+Bnr2bar)*(Lnr2-hl2*L2(-1))+cnr2);
		@#else
			rwnr1=0;
			rwnr2=0;
		@#endif
		
	//Phillips Curve, Calvo, indexation  eq LIN.42
		xi1*(pie1-gamma1*pie1(-1)) = xi1*beta1tilde*(1+g)*(pie1(+1)-gamma1*pie1) +(1-beta1tilde*(1+g)*xi1)*(1-xi1)*rmc1;
    xi2*(pie2-gamma2*pie2(-1)) = xi2*beta2tilde*(1+g)*(pie2(+1)-gamma2*pie2) +(1-beta2tilde*(1+g)*xi2)*(1-xi2)*rmc2;
		
	//Taylor rule  eq LIN.29 LIN.31 LIN.30 
		@#if DUMMIES
		// ATTENTION DUMMY
			r = (1-e_dummyTR)*(rho*r(-1)+(1-rho)*(rpi*pietildec+ry*y))+um;
		@#else	
			r = rho*r(-1)+(1-rho)*(rpi*pietildec+ry*y)+um;
		@#endif	
		pietildec = theta/(theta+(tbar^(1-alpha1-alpha2)*cy2bar)/cy1bar)*piec1+1/(1+(theta*cy1bar)/(tbar^(1-alpha1-alpha2)*cy2bar))*piec2; 
    y = theta/(theta+tbar)*y1+1/(1+theta/tbar)*y2;

	//Inflation, relative price and ToT  eq LIN.32 LIN.36 LIN.34 LIN.35
		rpc1= alpha1*t;
		rpc2= -alpha2*t;
		t=t(-1)+pie2-pie1;
		piec1 = (1-alpha1)*pie1 + alpha1*pie2;
		piec2 = (1-alpha2)*pie2 + alpha2*pie1;
				
	//Policy shocks (10+13+2+6)  
	    @#if NOTAX
        nuw1 = uw1; 
        nuw2 = uw2;
        nuc1 = uc1;
       	nuc2 = uc2;
		    nud1 = (ud1+uktot1);
		    nud2 = (ud2+uktot2);
		    nufd1 = (ufd1+uktot1);
		    nufd2 = (ufd2+uktot2);
		    nuk1 = (uk1+uktot1);
		    nuk2 = (uk2+uktot2);
        @#else
    //tax rate shocks (uw...) are the delta of the tax rates (in % point) and not the % of deviation from SS of the tax rates
        nuw1bar*nuw1 = uw1; 
        nuw2bar*nuw2 = uw2;
        nuc1bar*nuc1 = uc1;
       	nuc2bar*nuc2 = uc2;
		    nud1bar*nud1 = (ud1+uktot1);
		    nud2bar*nud2 = (ud2+uktot2);
		    nufd1bar*nufd1 = (ufd1+uktot1);
		    nufd2bar*nufd2 = (ufd2+uktot2);
		    nuk1bar*nuk1 = (uk1+uktot1);
		    nuk2bar*nuk2 = (uk2+uktot2);
        @#endif	
	// exogenous autocorrelation if needed (27 eq)
	//WARNING: as written here, same autocorrelation for every shock
        uprod1=arr*uprod1(-1)+e_prod1;
        uprod2=arr*uprod2(-1)+e_prod2;
        upref1=arr*upref1(-1)+e_pref1;
        upref2=arr*upref2(-1)+e_pref2;
        uinv1=arr*uinv1(-1)+e_inv1;
        uinv2=arr*uinv2(-1)+e_inv2;
        uphi1=arr*uphi1(-1)+e_phi1;
        uphi2=arr*uphi2(-1)+e_phi2;
        uphinr1=arr*uphinr1(-1)+e_phinr1;
        uphinr2=arr*uphinr2(-1)+e_phinr2;
        uphir1=arr*uphir1(-1)+e_phir1;
        uphir2=arr*uphir2(-1)+e_phir2;
        ug1=arr*ug1(-1)+e_ug1;
        ug2=arr*ug2(-1)+e_ug2;
        um=0*arr*um(-1)+e_um;
        uw1=arr*uw1(-1)+e_w1;
        uw2=arr*uw2(-1)+e_w2;
        uc1=arr*uc1(-1)+e_c1;
        uc2=arr*uc2(-1)+e_c2;
        ud1=arr*ud1(-1)+e_d1;
        ud2=arr*ud2(-1)+e_d2;
        ufd1=arr*ufd1(-1)+e_fd1;
        ufd2=arr*ufd2(-1)+e_fd2;
        uk1=arr*uk1(-1)+e_k1;
        uk2=arr*uk2(-1)+e_k2;
        uktot1=arr*uktot1(-1)+e_ktot1;
        uktot2=arr*uktot2(-1)+e_ktot2;
	
	//Total government spending (discretionary+rule) 
		    g1=gd1+ug1;
		    g2=gd2+ug2;
		
	// Transfers  
		    phir1 = (uphi1+uphir1)+phidr1;
		    phir2 = (uphi2+uphir2)+phidr2;
        @#if PHIRULE
            phidr1 = 0.9*phidr1(-1)+1/phir1bar*(0.01/pa1bar*pa1(-1)+0.1/pa1bar*(pa1-pa1(-1)));
            phidr2 = 0.9*phidr2(-1)+1/phir2bar*(0.01/pa2bar*pa2(-1)+0.1/pa2bar*(pa2-pa2(-1)));
        @#else 
            phidr1=0;
            phidr2=0;
        @#endif
  
	
		@#if NONRICARDIAN 
			phinr1 = (uphi1+uphinr1)+phidnr1;
			phinr2 = (uphi2+uphinr2)+phidnr2;
            @#if PHIRULE
                phidnr1 = 0.9*phidnr1(-1)+1/phinr1bar*(0.01/pa1bar*pa1(-1)+0.1/pa1bar*(pa1-pa1(-1)));
                phidnr2 = 0.9*phidnr2(-1)+1/phinr2bar*(0.01/pa2bar*pa2(-1)+0.1/pa2bar*(pa2-pa2(-1)));
            @#else 
                phidnr1=0;
                phidnr2=0;
            @#endif
		@#else
			phinr1 = phidnr1;
			phinr2 = phidnr2;
            phidnr1= 0;
            phidnr2= 0;
		@#endif
		
        phi1bar*phi1 = phir1bar*phir1+phinr1bar*phinr1;
	    phi2bar*phi2 = phir2bar*phir2+phinr2bar*phinr2;
		
	//Additional endogenous variables
	//Trade balance  
	tb = alpha2/theta*(tbar)^(1-alpha2)*(cy2bar*c2+iy2bar*I2)-alpha1*(tbar)^alpha1*(cy1bar*c1+iy1bar*I1)+(alpha2*(1-alpha2)/theta*(tbar)^(1-alpha2)*(cy2bar+iy2bar)-alpha1^2*(tbar)^alpha1*(cy1bar+iy1bar))*t;
	
	//Utilities
	Ur1 = eta1*(1-sigmac1)*(g1-hg1*g1(-1))+(1-sigmac1)*(1-eta1)*(cr1-hc1*c1(-1))-Br1bar*(Lr1-hl1*L1(-1));
	Ur2 = eta2*(1-sigmac2)*(g2-hg2*g2(-1))+(1-sigmac2)*(1-eta2)*(cr2-hc2*c2(-1))-Br2bar*(Lr2-hl2*L2(-1));
	
	Urc1 = (1-sigmac1)*(1-eta1)*(cr1-hc1*c1(-1));
	Urc2 = (1-sigmac2)*(1-eta2)*(cr2-hc2*c2(-1));
	
	Url1 = -Br1bar*(Lr1-hl1*L1(-1));
	Url2 = -Br2bar*(Lr2-hl2*L2(-1));
	
	Urg1 = eta1*(1-sigmac1)*(g1-hg1*g1(-1));
	Urg2 = eta2*(1-sigmac2)*(g2-hg2*g2(-1));
	
	@#if NONRICARDIAN
		Unr1 = eta1*(1-sigmac1)*(g1-hg1*g1(-1))+(1-sigmac1)*(1-eta1)*(cnr1-hc1*c1(-1))-Bnr1bar*(Lnr1-hl1*L1(-1));
		Unr2 = eta2*(1-sigmac2)*(g2-hg2*g2(-1))+(1-sigmac2)*(1-eta2)*(cnr2-hc2*c2(-1))-Bnr2bar*(Lnr2-hl2*L2(-1));
		Unrc1 = (1-sigmac1)*(1-eta1)*(cnr1-hc1*c1(-1));
		Unrc2 = (1-sigmac2)*(1-eta2)*(cnr2-hc2*c2(-1));
		Unrl1 = -Bnr1bar*(Lnr1-hl1*L1(-1));
		Unrl2 = -Bnr2bar*(Lnr2-hl2*L2(-1));
		Unrg1 = eta1*(1-sigmac1)*(g1-hg1*g1(-1));
		Unrg2 = eta2*(1-sigmac2)*(g2-hg2*g2(-1));
	@#else
		Unr1 = 0;
		Unr2 = 0;
		Unrc1 = 0;
		Unrc2 = 0;
		Unrl1 = 0;
		Unrl2 = 0;
		Unrg1 = 0;
		Unrg2 = 0;
	@#endif
end;
////////////////////////////////////////////////////////////////////


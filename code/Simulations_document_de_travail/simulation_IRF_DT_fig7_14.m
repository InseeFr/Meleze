%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MELEZE : A DSGE model for fiscal simulations in a monetary union
% Campagne B. & Poissonnier A., G2016/05, Insee.
%
%Programme de tracé des fonctions de réponse 
%des figures 7 à 14 du document de travail
%(partie 1 : réalisation des simulations)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% NOTA BENE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PHIRULE and NOTAX added to model but fixed in these simulations
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
%1. define working environment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	pwd % reminder of current directory W:\dynare\dsgefiscal\MELEZE
	
	% 1.1 Saving directory
    % check that the saving directory exist and may create it if it doesn't
	A = exist('SAVED_IRFS','dir');
	if A~=7
		button = questdlg(['There is no folder for saving the simulations. Should I create a folder in ', pwd, '?'] ,'Folder for saving the simulation');
		if button=='Yes'
			mkdir('SAVED_IRFS');
		else
		error('Meleze:looping', 'There is no folder for saving');
		end
	end
	
	% 1.2 Global input directory
    % check that the input directory exist and may create it if it doesn't
    % the input directory contains the calibration files
	B = exist('.\SAVED_Inputs','dir');
	if B~=7
		error('Meleze:looping', 'There is no folder for inputs');
	end
	

%2. define loop properties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 2.1 Definition of the simulations to be considered 
    
%     EULERGOV=[1,0]; % 1 if maximizing government, 0 if budget rule
%     CALIBTYPE={'calib_CalibrationFR_EU'}; % name of the calibration file
%     SIMULTYPE=[1,0];% 1 for stochastic 0 for deterministic
%     BRcalib=[0; 0; 0; 0.02]; % budget rule coefficients, lines correspond to BRar BRcycle BRrr BRdef 
%     VARexo_det{1}={'e_prod1'; 1;8;1}; % shocks, datedeb, datefin, value
%                                       % should defined as many
%                                       % VARexo_det{n} as necessary
%     VARexo_stoch={'e_prod1', 'e_pref1', '', 'e_ug1', 'e_w1', 'e_c1', 'e_d1', 'e_fd1', 'e_k1', 'e_phi1', 'e_phinr1'; 1,1,1,1,1,1,1,1,1,1,1}    
	 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for figure 7 to 14
      EULERGOV=[1,0,0,0];
      CALIBTYPE={'calib_CalibrationFR_EU'};                                 
      SIMULTYPE=[1]; 
      BRcalib=[0.9,0.9,0.9; 0,-0.01,0.04; 0,0,0; 0.02,0.02,0.02];
      VARexo_stoch{1}={'e_prod1','e_pref1','e_um','e_ug1';1,1,1,1};  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
	% 2.2 Create simulation variables from the previously defined vectors
	
        % 2.2.a check for dimension coherence in inputs
	leuler=length(EULERGOV);
	%ldummies=length(DUMMIES);
	lctype=length(CALIBTYPE);
	lsimtype=length(SIMULTYPE);
    %cumulate the stochastic and deterministic simulation specifications
    lVARexo_tempsto=0;
    lVARexo_tempdet=0;
    if exist('VARexo_stoch')==1; lVARexo_tempsto=length(VARexo_stoch); end;
    if exist('VARexo_det')==1; lVARexo_tempdet=length(VARexo_det); end;
    lVARexo= lVARexo_tempsto+lVARexo_tempdet; 
    %vector of lengths
	llength_temp=[leuler,lctype,lsimtype, lVARexo];
	max_l=max(llength_temp);
	min_l=min(llength_temp);
    
        % first tests on the length of the specification of the gov rule,
        % the caliibration file and the simulation type (the simple inputs)
    %if the input are not all of the same size    
	if max_l~=min_l;
        % I may repeat the last value (for the simple inputs)
		button = questdlg(['Inputs are not of the same length. Should I repeat last occurrences to solve this issue ?'] ,'Input parameters coherence');
		if button=='Yes';
			EULERGOV=[EULERGOV,repmat(EULERGOV(leuler),1,max_l-leuler)];
			%DUMMIES=[DUMMIES,repmat(DUMMIES(ldummies),1,max_l-ldummies)];
			CALIBTYPE=[CALIBTYPE,repmat(CALIBTYPE(lctype),1,max_l-lctype)];
			SIMULTYPE=[SIMULTYPE,repmat(SIMULTYPE(lsimtype),1,max_l-lsimtype)];
		else
		error('Meleze:looping', 'Not coherent input size (Eulergov, Calibtype, Simultype)');
		end
    end
    
        %additional tests on the specifications of stochastic and
        %deterministic simulations (complicated inputs)
    % if I specify more stochastic simulations than declared => ERROR
    if lVARexo_tempsto>sum(SIMULTYPE==1);
        error('Meleze:looping', 'Not coherent input size (VARexo_stoch longer than SIMULTYPE==1)');
    % if I specify too few but at least one
    elseif lVARexo_tempsto<sum(SIMULTYPE==1)&& lVARexo_tempsto>0;
        % I may repeat the last value
        button = questdlg(['Inputs (VARexo_stoch and SIMULTYPE) are not of the same length. Should I repeat last occurrences to solve this issue ?'] ,'Input parameters coherence');
		if button=='Yes';
            for k= (lVARexo_tempsto+1):sum(SIMULTYPE==1);
			VARexo_stoch{k}=VARexo_stoch{lVARexo_tempsto}; 
            end
        else
        %otherwise ERROR
		error('Meleze:looping', 'Not coherent input size (VARexo_stoch shorter than SIMULTYPE==1)');
        end
    % if I forgot to specify VARexostoch => ERROR    
    elseif lVARexo_tempsto==0 && sum(SIMULTYPE==1)>0;
        error('Meleze:looping', 'Not coherent input size (VARexo_stoch empty)');
    end
    
    % includes empty cells for the stochastic simulation when running a deterministic one
        VARexo_stoch_temp = cell(1,max_l);  % initializes with empty cells
        position_temp=find(SIMULTYPE==1); % selects the position of stochastich simuls
        for k=1:sum(SIMULTYPE);
            VARexo_stoch_temp{position_temp(k)}=VARexo_stoch{k}; % each stochastic simulation's specification is repositioned in the full sequence of simulations (that is include deterministic ones)
        end
        VARexo_stoch=VARexo_stoch_temp;
   
    % symetric operations for VARexo_det
    if lVARexo_tempdet>sum(SIMULTYPE==0);
        error('Meleze:looping', 'Not coherent input size (VARexo_det longer than SIMULTYPE==0)');
    elseif lVARexo_tempdet<sum(SIMULTYPE==0)&& lVARexo_tempdet>0;
        button = questdlg(['Inputs (VARexo_det and SIMULTYPE) are not of the same length. Should I repeat last occurrences to solve this issue ?'] ,'Input parameters coherence');
		if button=='Yes';
            for k= (lVARexo_tempdet+1):sum(SIMULTYPE==0);
			VARexo_det{k}=VARexo_det{lVARexo_tempdet};
            end
		else
		error('Meleze:looping', 'Not coherent input size (VARexo_det shorter than SIMULTYPE==1)');
        end
    elseif lVARexo_tempdet==0 && sum(SIMULTYPE==0)>0;
        error('Meleze:looping', 'Not coherent input size (VARexo_det empty)');
    end
    % includes empty cells for the deterministic simulation
        VARexo_det_temp = cell(1,max_l);  % initializes with empty cells
        position_temp=find(SIMULTYPE==0); % selects the position of deterministic simuls
        for k=1:sum(SIMULTYPE==0);
            VARexo_det_temp{position_temp(k)}=VARexo_det{k}; % each deterministic simulation's specification is repositioned in the full sequence of simulations (that is include stochastic ones)
        end
        VARexo_det=VARexo_det_temp;
      
    
        % 2.2.b checks that the parameters for the budget rule are in the right quantity
            % if not may repeat last specification
    leuler=length(EULERGOV);
    BRcalib_temp=zeros(4,leuler);
    if sum(EULERGOV==0)>0; % if i need to specify calibrations
        %either I haven't => ERROR
        if exist('BRcalib')==0;
            error('Meleze:looping', 'Missing input (BRcalib)');
        end
        % or I have
        [m_BRcalib_temp,n_BRcalib_temp]=size(BRcalib);
        %If it's too long ERROR
        if leuler<n_BRcalib_temp;
            error('Meleze:looping', 'Too long input (BRcalib)');
        end
        %If it's the correct size
        if leuler==n_BRcalib_temp ;
            BRcalib_temp=BRcalib; % I won't modify it
        % if it's shorter    
        elseif leuler~=n_BRcalib_temp ;
            % either I should just put zeros for the simulations without budget rule 
            if  (sum(EULERGOV==0)) ==n_BRcalib_temp;
                BRcalib_temp(1:4,EULERGOV==0)=BRcalib;
            % or I should first repeat the last calibration    
            elseif (sum(EULERGOV==0)) > n_BRcalib_temp;
            button = questdlg(['Inputs (BRcalib, Eulergov) are not of the same length, and I can not put the number of zeros corresponding to Euler simulations. Should I repeat last occurrences to solve this issue ?'] ,'Input parameters coherence');
                if button=='Yes';
                    BRcalib=[BRcalib,repmat(BRcalib(:,n_BRcalib_temp),1,sum(EULERGOV==0)-n_BRcalib_temp)];
                    BRcalib_temp(1:4,EULERGOV==0)=BRcalib;
                else
                %if I don't fix the size => ERROR
                error('Meleze:looping', 'Not coherent input size (Eulergov, BRcalib)');
                end
            % or there is a pb to the inputs    
            else % I don't know what to do => ERROR
                error('Meleze:looping', 'Not coherent input size (Eulergov, BRcalib)');
            end
         end
    end
    BRcalib=BRcalib_temp; % in the end the temporary matrix is filled and can replace the input
    
        % 2.2.c specific treatment for deterministic simulation
        
        % initialize vectors of dummies for accomodative policies
        DUMMIES_gov=0*SIMULTYPE; % the vector is initially zeros
        DUMMIES_cb=0*SIMULTYPE;
        position_temp=find(SIMULTYPE==0);
        %creates a dummy vector from the simulations specifications
        sub_dummies_gov_temp=SIMULTYPE(SIMULTYPE==0); % when the simulations are deterministic
        sub_dummies_cb_temp=SIMULTYPE(SIMULTYPE==0); % the vectors may take the value 1
        for i=1:length(position_temp);
            if isempty(strfind(strcat(VARexo_det{position_temp(i)}{1,:}), 'dummyBR'))==0; %if the shock dummyBR is in the list of shocks for the deterministic simulation
             sub_dummies_gov_temp(i)=1; % it takes the value 1 
            end
            if isempty(strfind(strcat(VARexo_det{position_temp(i)}{1,:}), 'dummyTR'))==0;
             sub_dummies_cb_temp(i)=1; % it takes the value 1 if the shock dummyTRis in the list of shocks for the deterministic simulation
            end
        end
        DUMMIES_gov(SIMULTYPE==0)=sub_dummies_gov_temp;
        DUMMIES_cb(SIMULTYPE==0)=sub_dummies_cb_temp;
        DUMMIES=DUMMIES_gov|DUMMIES_cb; % dummies is one if either the gov or central bank are accomodative (switch off their rule)
  
        
        % 2.2.d cell array of strings for output names
    EULERNAME=cellstr(repmat('EulerG',length(EULERGOV),1));
    EULERNAME(EULERGOV==0)=cellstr(repmat('BRule',sum(EULERGOV==0),1));
    DUMMYNAME_gov=cellstr(repmat('Accommodative_Gov',length(DUMMIES_gov),1));
    DUMMYNAME_gov(DUMMIES_gov==0)=cellstr(repmat('NotAccommodative_Gov',sum(DUMMIES_gov==0),1));
    DUMMYNAME_cb=cellstr(repmat('Accommodative_CB',length(DUMMIES_cb),1));
    DUMMYNAME_cb(DUMMIES_cb==0)=cellstr(repmat('NotAccommodative_CB',sum(DUMMIES_cb==0),1));
    SIMULNAME=cellstr(repmat('stoch',length(SIMULTYPE),1));
    SIMULNAME(SIMULTYPE==0)=cellstr(repmat('det',sum(SIMULTYPE==0),1));

    
        % 2.2.e checks for input calibrations files
        % there must be a file .\SAVED_Inputs\XXX.txt for each name in
        % calibtype
	ctype_temp=unique(CALIBTYPE);
	[m_temp,n_temp]=size(ctype_temp);
	thereiscalib=zeros(1,n_temp);
		for i=1:n_temp;
			thereiscalib(i) = exist(['.\SAVED_Inputs\',ctype_temp{i},'.txt'],'file');
			if thereiscalib(i)~=2; % takes the value 2 if there is a file with the right name, otherwise pb
				warning('There is no calibration file for %s',ctype_temp{i});
			end;
		end;
		if length(ctype_temp(thereiscalib~=2))>0
		error('Meleze:looping', 'Some calibration files are missing!');
		end;
	
%3. launch loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for i=1:max_l;
		%3.1 write temporary txt
        %i=1
		% copy calibration from a previously prepared calibration file
			if i==1;
                copyfile(['.\SAVED_Inputs\',CALIBTYPE{i},'.txt'],'calib_temp.txt');
             elseif  strcmp(CALIBTYPE{i},CALIBTYPE{i-1})==0 ;
 				copyfile(['.\SAVED_Inputs\',CALIBTYPE{i},'.txt'],'calib_temp.txt');
 			end
 		
		% Euler or government spending rule
		%if  i>1 && BRcalib(:,i)~=BRcalib(:,i-1)
			fid = fopen('EulerORBR_temp.txt','w');
			formatSpec = '@#define EULERGOV= %1.0f \n';
			fprintf(fid, formatSpec,EULERGOV(i));
			if EULERGOV(i)~=1;
				CC = {'BRar', 'BRcycle', 'BRrr' ,'BRdef'; BRcalib(1,i),BRcalib(2,i),BRcalib(3,i),BRcalib(4,i)};
				formatSpec = '%s = %1.0e ;\n';
				fprintf(fid, formatSpec,CC{:});
			end
			fclose(fid);
		%end;

		% Dummies on gov or central bank
		%if i>1 && DUMMIES(i)~=DUMMIES(i-1) 
			fid = fopen('DummiesORNot_temp.txt','w');
			formatSpec = '@#define DUMMIES= %1.0f \n';
			fprintf(fid, formatSpec,DUMMIES(i));
			fclose(fid);
		%end;	

		% shock choices (+ duration timing)
		
 			%fid = fopen([num2str(i),'shocks_temp.txt'],'w');
            fid = fopen('shocks_temp.txt','w');
			if SIMULTYPE(i)==1 %stochastic
				fprintf(fid,'shocks; \n');
				formatSpec = 'var %s ;\n stderr %1.12e ;\n';
				fprintf(fid, formatSpec,VARexo_stoch{i}{:});
				fprintf(fid,'end; \n stoch_simul(periods=500, irf = 100, noprint); \n close all;');
			else  %deterministic
				fprintf(fid,'shocks; \n');
				formatSpec = 'var %s ;\n periods %d:%d ;\n values %1.12e ;\n';
				fprintf(fid, formatSpec,VARexo_det{i}{:});
				fprintf(fid,'end; \n simul(periods=500);');
			end
			%n'oublie pas de fermer le fichier sinon tu ne peux pas le lire
 			fclose(fid);
	
			
		%3.2 runs dynare
			%dynare efface toute la work quand il est lancée
			%il faut bien tout sauvergarder, y compris le compteur de la boucle !
            % ou utiliser noclearall option ?
            save tempo.mat i max_l EULERGOV DUMMIES DUMMIES_gov DUMMIES_cb CALIBTYPE SIMULTYPE SIMULNAME BRcalib EULERNAME DUMMYNAME_gov DUMMYNAME_cb VARexo_det VARexo_stoch ;
			%dynare meleze.mod
            fprintf(['_______________________________ \n\n Ceci est un message d''Aurélien et Benoît: \n This is iteration ', num2str(i), ' of the loop on MELEZE\n_______________________________ \n '])
            dynare meleze_loop.mod nostrict
			load tempo.mat;

		%3.3 saves output
            %little detour for a nice name to the files
            % takes the values of the calibration of the BR on a line
            toto=transpose(BRcalib(:,i));
            % put it into a string
            toto2=num2str(toto);
            % finds the many spaces
            tata=find(isspace(toto2)==0);
            % keeps only on space per sequence of spaces
            tata=unique(sort([tata,tata+1]));
            tata=tata(1:(end-1));
            % replaces the spaces by underscores
            toto3=toto2(tata);
            toto4=strrep(toto3, ' ', '_');
            % and dot by commas (extension issues otherwise)
            toto4=strrep(toto4, '.', ',');
        
 			if strcmp(SIMULNAME{i},'stoch');
 				llist=fieldnames(oo_.irfs);
 				save(['.\SAVED_IRFS\IRF_',CALIBTYPE{i},'_',SIMULNAME{i},'_',EULERNAME{i},'_',toto4], llist{:},'VARexo_stoch','BRcalib','i');
 			elseif strcmp(SIMULNAME{i},'det');
 				llist=cellstr(M_.endo_names);
 				save(['.\SAVED_IRFS\IRF_',CALIBTYPE{i},'_',SIMULNAME{i},'_',DUMMYNAME_gov{i},'_',DUMMYNAME_cb{i},'_',EULERNAME{i},'_',toto4,'_',VARexo_det{i}{1},'_',num2str(VARexo_det{i}{3})], llist{:},'VARexo_det','BRcalib','i');
 			else 
 				error('Meleze:looping', 'I have a problem when saving data. I don''t know the simulation type');
 			end;

	end;	

    
    
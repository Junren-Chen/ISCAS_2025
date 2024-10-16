%% ----------- ISCAS 2025: Analyzing normalized sensing margin k'/k, validating the mathematical model vs. SPICE circuit simulation   ---------------  %%
% This matlab script includes the analysis and figures of the ISCAS 2025 paper
% Author: Junren Chen, Institute of Neuroinformatics (INI), UZH & ETH, Switzerland
% Date:   Wednesday, Sept 11, 2024        Place: INI, Zurich
% Email:  stephenchen.0907@gmail.com , junren@ini.uzh.ch
% This code script is licensed with a CC-BY international license 4.0.

% This work is a follow-up of the paper: (DOI: 10.1109/TCSII.2023.3343292)
% J. Chen, S. Yang, H. Wu, G. Indiveri, and M. Payvand, "Scaling limits of memristor-based routers for asynchronous neuromorphic systems,"IEEE Transactions on Circuits and Systems II: Express Briefs, 2023. 
% -------------------------------------------------------------------------------------------------------- %
close all;  
clear all;   
clc
%% resistance of Transistor in 1T1R when reading
% When Vg=VDD (in 22nm FDSOI, 0.9V),
% According to the simulation of Rt (read resistance from NMOS in 1T1R), Rt_22nm = 1.7k Ohm.
Rt_180nm = 800;  % Ohm @ VDD=1.8V
Rt_22nm = 1.7e3; % Ohm
% Rt_28nm = 1.7e3; % Ohm
%% define on/off ratio of memristors
k10 = 10;
k20 = 20;
k100 = 100;
%% sweep the size of the array
Nr = [64, 128, 256, 512, 1024, 2048, 4096];
%% 22nm FDSOI SPICE simulation, normal NFET, W=210nm,L=40nm, 
% when r=0, Nr=1024, all Vg=0,  Cadence simulation setting iabsol=1e-15, gmin=1e-15, leakage accumulation of all the 1024 cells on BL is
% Ileak_1024 = 42.1108  % nA, @ Rmem=1M Ohm
% Ileak_1024 = 42.1132  % nA, @ Rmem=100k Ohm
% Ileak_1024 = 42.1135  % nA, @ Rmem=0 Ohm
% when r=2.5 Ohm, Nr=1024, all Vg=0, 
% Ileak_1024 = 42.0589  % nA, @ Rmem=1k Ohm
% Ileak_1024 = 42.0564  % nA, @ Rmem=1M Ohm
% Ileak_1024 = 39.5276  % nA, @ Rmem=1G Ohm
%%%%%%%%% This indicates that the resistance of memory cell and the metal line resistance does not influence the transistor leakage, which
%%%%%%%%% is expected.

% Ron_vec =  [1e3,  2e3, 5e3, 1e4, 2e4, 5e4, 1e5, 2e5, 5e5, 1e6, 2e6, 5e6, 1e7, 5e7, 1e8];
% Roff_vec = [1e4,  2e4, 5e4, 1e5, 2e5, 5e5, 1e6, 2e6, 5e6, 1e7, 2e7, 5e7, 1e8, 5e8, 1e9]; % on/off ratio k = 10

%% --------------------------------- Cadence Spectre (SPICE) circuit simulations
% r=2.5 Ohm, Vread=0.2V
%% Nr=1024, WL511=1. Switch on WL 511, the current including IR drop effect and transistor leakage currents
I_R1k   = 37.8812 * 1000;  % uA to nA, with resistance of memory cell is 1k Ohm.
I_R2k   = 32.0009 * 1000;  % uA to nA
I_R5k   = 21.729  * 1000;  % uA to nA
I_R10k  = 14.1222 * 1000;  % uA to nA
I_R20k  = 8.3052  * 1000;  % uA to nA
I_R50k  = 3.7290  * 1000;  % uA to nA
I_R100k = 1.959   * 1000;  % uA to nA
I_R200k = 1.01997 * 1000;  % uA to nA
I_R500k = 438.022;  % nA
I_R1M   = 240.841;  % nA
I_R2M   = 141.638;  % nA
I_R5M   = 81.9137;  % nA
I_R10M  = 61.962;   % nA
I_R20M  = 51.9597;  % nA
I_R50M  = 45.8927;  % nA
I_R100M = 43.7643;  % nA
I_R500M = 41.1389;  % nA
I_R1G   = 39.7050;  % nA

% on/off ratio of circuit simulations, k' = Ion/Ioff
Spice_k10_R1k_Nr1024   = I_R1k/I_R10k;  
Spice_k10_R2k_Nr1024   = I_R2k/I_R20k;
Spice_k10_R5k_Nr1024   = I_R5k/I_R50k;
Spice_k10_R10k_Nr1024  = I_R10k/I_R100k;
Spice_k10_R20k_Nr1024  = I_R20k/I_R200k;
Spice_k10_R50k_Nr1024  = I_R50k/I_R500k;
Spice_k10_R100k_Nr1024 = I_R100k/I_R1M;
Spice_k10_R200k_Nr1024 = I_R200k/I_R2M;
Spice_k10_R500k_Nr1024 = I_R500k/I_R5M;
Spice_k10_R1M_Nr1024   = I_R1M/I_R10M;
Spice_k10_R2M_Nr1024   = I_R2M/I_R20M;
Spice_k10_R5M_Nr1024   = I_R5M/I_R50M;
Spice_k10_R10M_Nr1024  = I_R10M/I_R100M;
Spice_k10_R50M_Nr1024  = I_R50M/I_R500M;
Spice_k10_R100M_Nr1024 = I_R100M/I_R1G;

% normalized sening margin: k'/k
Sp_norm_k10_R1k_Nr1024   = Spice_k10_R1k_Nr1024   / k10;
Sp_norm_k10_R2k_Nr1024   = Spice_k10_R2k_Nr1024   / k10;
Sp_norm_k10_R5k_Nr1024   = Spice_k10_R5k_Nr1024   / k10;
Sp_norm_k10_R10k_Nr1024  = Spice_k10_R10k_Nr1024  / k10;
Sp_norm_k10_R20k_Nr1024  = Spice_k10_R20k_Nr1024  / k10;
Sp_norm_k10_R50k_Nr1024  = Spice_k10_R50k_Nr1024  / k10;
Sp_norm_k10_R100k_Nr1024 = Spice_k10_R100k_Nr1024 / k10;
Sp_norm_k10_R200k_Nr1024 = Spice_k10_R200k_Nr1024 / k10;
Sp_norm_k10_R500k_Nr1024 = Spice_k10_R500k_Nr1024 / k10;
Sp_norm_k10_R1M_Nr1024   = Spice_k10_R1M_Nr1024   / k10;
Sp_norm_k10_R2M_Nr1024   = Spice_k10_R2M_Nr1024   / k10;
Sp_norm_k10_R5M_Nr1024   = Spice_k10_R5M_Nr1024   / k10;
Sp_norm_k10_R10M_Nr1024  = Spice_k10_R10M_Nr1024  / k10;
Sp_norm_k10_R50M_Nr1024  = Spice_k10_R50M_Nr1024  / k10;
Sp_norm_k10_R100M_Nr1024 = Spice_k10_R100M_Nr1024 / k10;

% attach to a vector for ploting
Sp_norm_k10_Nr1024_vec = [Sp_norm_k10_R1k_Nr1024, Sp_norm_k10_R2k_Nr1024, Sp_norm_k10_R5k_Nr1024, Sp_norm_k10_R10k_Nr1024, Sp_norm_k10_R20k_Nr1024, Sp_norm_k10_R50k_Nr1024, Sp_norm_k10_R100k_Nr1024, Sp_norm_k10_R200k_Nr1024, ...
                          Sp_norm_k10_R500k_Nr1024, Sp_norm_k10_R1M_Nr1024, Sp_norm_k10_R2M_Nr1024, Sp_norm_k10_R5M_Nr1024, Sp_norm_k10_R10M_Nr1024, Sp_norm_k10_R50M_Nr1024, Sp_norm_k10_R100M_Nr1024];

                      
%% Nr=256£¬ simulation: iabsol=1e-15, gmin=1e-15, WL127=1.
I_R1k_Nr256   = 59.7803 * 1000;  % uA to nA
I_R2k_Nr256   = 46.4376 * 1000;  % uA to nA
I_R5k_Nr256   = 27.5284 * 1000;  % uA to nA
I_R10k_Nr256  = 16.3374 * 1000;  % uA to nA
I_R20k_Nr256  = 9.0037  * 1000;  % uA to nA
I_R50k_Nr256  = 3.8394  * 1000;  % uA to nA
I_R100k_Nr256 = 1.9667  * 1000;  % uA to nA
I_R200k_Nr256 = 999.3897;  % nA
I_R500k_Nr256 = 408.6846;  % nA
I_R1M_Nr256   = 210.0341;  % nA
I_R2M_Nr256   = 110.3774;  % nA
I_R5M_Nr256   = 50.4755;   % nA  
I_R10M_Nr256  = 30.488;    % nA
I_R20M_Nr256  = 20.4856;  % nA
I_R50M_Nr256  = 14.4673;  % nA
I_R100M_Nr256 = 12.4345;  % nA
I_R500M_Nr256 = 10.5773;  % nA
I_R1G_Nr256   = 10.0704;  % nA

% on/off ratio of circuit simulations, k' = Ion/Ioff
Spice_k10_R1k_Nr256   = I_R1k_Nr256  / I_R10k_Nr256;
Spice_k10_R2k_Nr256   = I_R2k_Nr256  / I_R20k_Nr256;
Spice_k10_R5k_Nr256   = I_R5k_Nr256  / I_R50k_Nr256;
Spice_k10_R10k_Nr256  = I_R10k_Nr256 / I_R100k_Nr256;
Spice_k10_R20k_Nr256  = I_R20k_Nr256 / I_R200k_Nr256;
Spice_k10_R50k_Nr256  = I_R50k_Nr256 / I_R500k_Nr256;
Spice_k10_R100k_Nr256 = I_R100k_Nr256/ I_R1M_Nr256;
Spice_k10_R200k_Nr256 = I_R200k_Nr256/ I_R2M_Nr256;
Spice_k10_R500k_Nr256 = I_R500k_Nr256/ I_R5M_Nr256;
Spice_k10_R1M_Nr256   = I_R1M_Nr256  / I_R10M_Nr256;
Spice_k10_R2M_Nr256   = I_R2M_Nr256  / I_R20M_Nr256;
Spice_k10_R5M_Nr256   = I_R5M_Nr256  / I_R50M_Nr256;
Spice_k10_R10M_Nr256  = I_R10M_Nr256 / I_R100M_Nr256;
Spice_k10_R50M_Nr256  = I_R50M_Nr256 / I_R500M_Nr256;
Spice_k10_R100M_Nr256 = I_R100M_Nr256/ I_R1G_Nr256;

% normalized sening margin: k'/k
Sp_norm_k10_R1k_Nr256   = Spice_k10_R1k_Nr256   / k10;
Sp_norm_k10_R2k_Nr256   = Spice_k10_R2k_Nr256   / k10;
Sp_norm_k10_R5k_Nr256   = Spice_k10_R5k_Nr256   / k10;
Sp_norm_k10_R10k_Nr256  = Spice_k10_R10k_Nr256  / k10;
Sp_norm_k10_R20k_Nr256  = Spice_k10_R20k_Nr256  / k10;
Sp_norm_k10_R50k_Nr256  = Spice_k10_R50k_Nr256  / k10;
Sp_norm_k10_R100k_Nr256 = Spice_k10_R100k_Nr256 / k10;
Sp_norm_k10_R200k_Nr256 = Spice_k10_R200k_Nr256 / k10;
Sp_norm_k10_R500k_Nr256 = Spice_k10_R500k_Nr256 / k10;
Sp_norm_k10_R1M_Nr256   = Spice_k10_R1M_Nr256   / k10;
Sp_norm_k10_R2M_Nr256   = Spice_k10_R2M_Nr256   / k10;
Sp_norm_k10_R5M_Nr256   = Spice_k10_R5M_Nr256   / k10;
Sp_norm_k10_R10M_Nr256  = Spice_k10_R10M_Nr256  / k10;
Sp_norm_k10_R50M_Nr256  = Spice_k10_R50M_Nr256  / k10;
Sp_norm_k10_R100M_Nr256 = Spice_k10_R100M_Nr256 / k10;

Sp_norm_k10_Nr256_vec = [Sp_norm_k10_R1k_Nr256, Sp_norm_k10_R2k_Nr256, Sp_norm_k10_R5k_Nr256, Sp_norm_k10_R10k_Nr256, Sp_norm_k10_R20k_Nr256, Sp_norm_k10_R50k_Nr256, Sp_norm_k10_R100k_Nr256, Sp_norm_k10_R200k_Nr256, ...
                          Sp_norm_k10_R500k_Nr256, Sp_norm_k10_R1M_Nr256, Sp_norm_k10_R2M_Nr256, Sp_norm_k10_R5M_Nr256, Sp_norm_k10_R10M_Nr256, Sp_norm_k10_R50M_Nr256, Sp_norm_k10_R100M_Nr256];
%% --------------------------------- End of Cadence Spectre (SPICE) circuit simulations
                      

%% --------------------------------- Mathematical modeling
%% 22nm FDSOI BL/SL:
% M1, M2 resistance: 17 Ohm/um, @ metal height=0.07um, metal width=0.04um. M3: 10 Ohm/um,  R=Rs*L/W
Rs_22nm_M1 = 17*0.04/1;  % R*W/L (0.68 Ohm/sq), calculating sheet resistance 
Rs_22nm_M3 = 10*0.044/1; % R*W/L (0.44 Ohm/sq), calculating sheet resistance 
% The unit resistance r can be estimated by r=Rs * Lr/Wr (length/width of the metal connecting adjacent memory cells)\
% For example, Lr=0.8um, Wr=0.2um, r approx. 2 Ohm
%% Assuming r=2.5 Ohm in 28/22nm
r_22nm = 2.5;

%% Ron = 10K
Ron_10K = 10e3; %Ohm
kp_22nm_k10_Ron10K = k_p_vs_Nr(k10, Rt_22nm, Nr, r_22nm, Ron_10K);
norm_kp_22nm_k10_Ron10K = kp_22nm_k10_Ron10K/k10;  % normalize k'/k
kp_22nm_k10_Ron10K_validate = k_p_vs_Nr_validate(k10, Rt_22nm, Nr, r_22nm, Ron_10K);  % double check if the model is coded correctly

kp_22nm_k20_Ron10K = k_p_vs_Nr(k20, Rt_22nm, Nr, r_22nm, Ron_10K);
norm_kp_22nm_k20_Ron10K = kp_22nm_k20_Ron10K/k20;  % normalize k'/k
kp_22nm_k20_Ron10K_validate = k_p_vs_Nr_validate(k20, Rt_22nm, Nr, r_22nm, Ron_10K);  % double check if the model is coded correctly

kp_22nm_k100_Ron10K = k_p_vs_Nr(k100, Rt_22nm, Nr, r_22nm, Ron_10K);
norm_kp_22nm_k100_Ron10K = kp_22nm_k100_Ron10K/k100;  % normalize k'/k
kp_22nm_k100_Ron10K_validate = k_p_vs_Nr_validate(k100, Rt_22nm, Nr, r_22nm, Ron_10K);  % double check if the model is coded correctly

%% Ron = 50K
Ron_50K = 50e3; %Ohm
kp_22nm_k10_Ron50K = k_p_vs_Nr(k10, Rt_22nm, Nr, r_22nm, Ron_50K);
norm_kp_22nm_k10_Ron50K = kp_22nm_k10_Ron50K/k10; 
kp_22nm_k10_Ron50K_validate = k_p_vs_Nr_validate(k10, Rt_22nm, Nr, r_22nm, Ron_50K);

kp_22nm_k20_Ron50K = k_p_vs_Nr(k20, Rt_22nm, Nr, r_22nm, Ron_50K);
norm_kp_22nm_k20_Ron50K = kp_22nm_k20_Ron50K/k20;

kp_22nm_k100_Ron50K = k_p_vs_Nr(k100, Rt_22nm, Nr, r_22nm, Ron_50K);
norm_kp_22nm_k100_Ron50K = kp_22nm_k100_Ron50K/k100;

%% Ron = 100K
Ron_100K = 100e3; %Ohm
kp_22nm_k10_Ron100K = k_p_vs_Nr(k10, Rt_22nm, Nr, r_22nm, Ron_100K);
norm_kp_22nm_k10_Ron100K = kp_22nm_k10_Ron100K/k10; 
kp_22nm_k10_Ron100K_validate = k_p_vs_Nr_validate(k10, Rt_22nm, Nr, r_22nm, Ron_100K);

kp_22nm_k20_Ron100K = k_p_vs_Nr(k20, Rt_22nm, Nr, r_22nm, Ron_100K);
norm_kp_22nm_k20_Ron100K = kp_22nm_k20_Ron100K/k20;

kp_22nm_k100_Ron100K = k_p_vs_Nr(k100, Rt_22nm, Nr, r_22nm, Ron_100K);
norm_kp_22nm_k100_Ron100K = kp_22nm_k100_Ron100K/k100;

%% --------------------------------------------------------- plot effect of r only
I_Tleak_22nm = 0;

fig1 = figure();
fig1.Position(3:4) = [400 420];
ax = gca;

plot(Nr,norm_kp_22nm_k10_Ron10K, 'o-','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
hold on
% If you want to compare the influence of k, uncomment the plots of k20 and k100, which gives you the results of of Fig.8 in TCAS-II paper "Scaling Limits of Memristor-Based Routers for Asynchronous Neuromorphic Systems"
% plot(Nr,norm_kp_22nm_k20_Ron10K, 'ok-','Linewidth',1.5, 'MarkerFaceColor','k');
% plot(Nr,norm_kp_22nm_k100_Ron10K, 'o-','Linewidth',1.5, 'Color',rgb('DarkOrange'), 'MarkerFaceColor',rgb('DarkOrange'));

P_50K = plot(Nr,norm_kp_22nm_k10_Ron50K, 's--','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
% plot(Nr,norm_kp_22nm_k20_Ron50K, 'sk--','Linewidth',1.5, 'MarkerFaceColor','k');
% plot(Nr,norm_kp_22nm_k100_Ron50K, 's--','Linewidth',1.5, 'Color',rgb('DarkOrange'), 'MarkerFaceColor',rgb('DarkOrange'));

P_100K = plot(Nr,norm_kp_22nm_k10_Ron100K, ':','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880]);
% plot(Nr,norm_kp_22nm_k20_Ron100K, 'k:','Linewidth',1.5);
% plot(Nr,norm_kp_22nm_k100_Ron100K, ':','Linewidth',1.5, 'Color',rgb('DarkOrange'));
P_10K = plot(Nr,norm_kp_22nm_k10_Ron10K, 'o-','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
hold off

text(128, 0.61,{['$r =$ ', num2str(r_22nm), '$\Omega$'],['$I_{Tleak}=$ ', num2str(I_Tleak_22nm*1e12), '$pA$'], ['$R_T =$ ', num2str(Rt_22nm/1e3), '$k\Omega$'],['$k =$ ', num2str(k10)]},'interpreter','latex', 'FontSize',16);  %

set(gca,'linewidth',1.5,'fontsize',16);
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.2);
ylabel('Norm. margin $k''/k$', 'FontSize',22, 'Fontname','Times New Roman', 'interpreter','latex');
xlabel('Array size $N_r$','FontSize',20, 'Fontname','Times New Roman', 'interpreter','latex'); 
xlim([0,4200]);
set(gca,'XTick',[0, 1000, 2000, 3000, 4000]);
ylim([0.4,1.02]);
% If you want to compare the influence of k, uncomment the legend of k20 and k100 and comment leg2, which gives you the results of of Fig.8 in TCAS-II paper "Scaling Limits of Memristor-Based Routers for Asynchronous Neuromorphic Systems"
% leg1=legend({['$k = $ ', num2str(k10)],['$k = $ ', num2str(k20)],['$k = $ ', num2str(k100)]}, 'interpreter','latex', 'Location','best');
ah2=axes('position',get(gca,'position'),'visible','off');
leg2 = legend(ah2, [P_10K, P_50K, P_100K],{['$R_{on} =$ ', num2str(Ron_10K/1e3), '$k\Omega$'],['$R_{on} =$ ', num2str(Ron_50K/1e3), '$k\Omega$'],['$R_{on} =$ ', num2str(Ron_100K/1e3), '$k\Omega$']},'interpreter','latex', 'Location', 'southeast','FontSize',14);
legend('boxoff')
ax.Color = 'none';

%% --------------------------------------------------------- plot effect of ITleak only
%%  r=0, sweep Nr, study the effect of transistor leakage I_Tleak
Vread = 0.2; % Volt
r0 = 0;
I_Tleak_22nm = 40e-12; % 40pA , leakage of 22nm transtor approx. 22nm 

% Ron = 10K
kp_22nm_k10_Ron10K_r0 = kp_vs_Nr_complete(k10, Rt_22nm, Nr, r0, Ron_10K, Vread, I_Tleak_22nm);
norm_kp_22nm_k10_Ron10K_r0 = kp_22nm_k10_Ron10K_r0 / k10; 

kp_22nm_k20_Ron10K_r0 = kp_vs_Nr_complete(k20, Rt_22nm, Nr, r0, Ron_10K, Vread, I_Tleak_22nm);
norm_kp_22nm_k20_Ron10K_r0 = kp_22nm_k20_Ron10K_r0 / k20;   % normalize k'/k

kp_22nm_k100_Ron10K_r0 = kp_vs_Nr_complete(k100, Rt_22nm, Nr, r0, Ron_10K, Vread, I_Tleak_22nm);
norm_kp_22nm_k100_Ron10K_r0 = kp_22nm_k100_Ron10K_r0 / k100;   % normalize k'/k

% Ron = 50K
Ron_50K = 50e3; %Ohm
kp_22nm_k10_Ron50K_r0 = kp_vs_Nr_complete(k10, Rt_22nm, Nr, r0, Ron_50K, Vread, I_Tleak_22nm);
norm_kp_22nm_k10_Ron50K_r0 = kp_22nm_k10_Ron50K_r0 / k10; 

kp_22nm_k20_Ron50K_r0 = kp_vs_Nr_complete(k20, Rt_22nm, Nr, r0, Ron_50K, Vread, I_Tleak_22nm);
norm_kp_22nm_k20_Ron50K_r0 = kp_22nm_k20_Ron50K_r0 / k20; 

kp_22nm_k100_Ron50K_r0 = kp_vs_Nr_complete(k100, Rt_22nm, Nr, r0, Ron_50K, Vread, I_Tleak_22nm);
norm_kp_22nm_k100_Ron50K_r0 = kp_22nm_k100_Ron50K_r0 / k100; 

% Ron = 100K
Ron_100K = 100e3; %Ohm
kp_22nm_k10_Ron100K_r0 = kp_vs_Nr_complete(k10, Rt_22nm, Nr, r0, Ron_100K, Vread, I_Tleak_22nm);
norm_kp_22nm_k10_Ron100K_r0 = kp_22nm_k10_Ron100K_r0 / k10; 

kp_22nm_k20_Ron100K_r0 = kp_vs_Nr_complete(k20, Rt_22nm, Nr, r0, Ron_100K, Vread, I_Tleak_22nm);
norm_kp_22nm_k20_Ron100K_r0 = kp_22nm_k20_Ron100K_r0 / k20; 

kp_22nm_k100_Ron100K_r0 = kp_vs_Nr_complete(k100, Rt_22nm, Nr, r0, Ron_100K, Vread, I_Tleak_22nm);
norm_kp_22nm_k100_Ron100K_r0 = kp_22nm_k100_Ron100K_r0 / k100; 

% plot effect of Tleak only
fig = figure();
fig.Position(3:4) = [400 420];
ax = gca;

P_10K = plot(Nr,norm_kp_22nm_k10_Ron10K_r0, 'o-','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
hold on
% plot(Nr,norm_kp_22nm_k20_Ron10K_r0, 'ok-','Linewidth',1.5, 'MarkerFaceColor','k');
% plot(Nr,norm_kp_22nm_k100_Ron10K_r0, 'o-','Linewidth',1.5, 'Color',rgb('DarkOrange'), 'MarkerFaceColor',rgb('DarkOrange'));

P_50K = plot(Nr,norm_kp_22nm_k10_Ron50K_r0, 's--','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
% plot(Nr,norm_kp_22nm_k20_Ron50K_r0, 'sk--','Linewidth',1.5, 'MarkerFaceColor','k');
% plot(Nr,norm_kp_22nm_k100_Ron50K_r0, 's--','Linewidth',1.5, 'Color',rgb('DarkOrange'), 'MarkerFaceColor',rgb('DarkOrange'));

P_100K = plot(Nr,norm_kp_22nm_k10_Ron100K_r0, ':','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880]);
% plot(Nr,norm_kp_22nm_k20_Ron100K_r0, 'k:','Linewidth',1.5);
% plot(Nr,norm_kp_22nm_k100_Ron100K_r0, ':','Linewidth',1.5, 'Color',rgb('DarkOrange'));
% P_10K = plot(Nr,norm_kp_22nm_k10_Ron10K_r0, 'o-','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
hold off

text(128, 0.61,{['$r =$ ', num2str(r0), '$\Omega$'], ['$I_{Tleak}=$ ', num2str(I_Tleak_22nm*1e12), '$pA$'], ['$R_T =$ ', num2str(Rt_22nm/1e3), '$k\Omega$'], ['$k =$ ', num2str(k10)]},'interpreter','latex', 'FontSize',16);  %

set(gca,'linewidth',1.5,'fontsize',16);
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.2);
ylabel('Norm. margin $k''/k$', 'FontSize',22, 'Fontname','Times New Roman', 'interpreter','latex');
xlabel('Array size $N_r$','FontSize',20, 'Fontname','Times New Roman', 'interpreter','latex'); 
xlim([0,4200]);
set(gca,'XTick',[0, 1000, 2000, 3000, 4000]);
ylim([0.4,1.02]);
% set(gca, 'XScale', 'log')
% leg1=legend({['$k = $ ', num2str(k10)],['$k = $ ', num2str(k20)],['$k = $ ', num2str(k100)]}, 'interpreter','latex', 'Location','best');

ah2=axes('position',get(gca,'position'),'visible','off');
leg2 = legend(ah2, [P_10K, P_50K, P_100K],{['$R_{on} =$ ', num2str(Ron_10K/1e3), '$k\Omega$'],['$R_{on} =$ ', num2str(Ron_50K/1e3), '$k\Omega$'],['$R_{on} =$ ', num2str(Ron_100K/1e3), '$k\Omega$']},'interpreter','latex', 'Location', 'southeast','FontSize',14);
legend('boxoff')
ax.Color = 'none';


%% ------------------------------------------------------- Joint effect of transistor leakage ITleak + r in 22nm
%%  r=2.5, sweep Nr, study the effect of transistor leakage ITleak + r in 22nm
r_22nm = 2.5;
I_Tleak_22nm =  40e-12; % 40pA , leakage of 22nm transtor approx. 22nm 

% Ron = 10K
kp_22nm_k10_Ron10K_r_22nm = kp_vs_Nr_complete(k10, Rt_22nm, Nr, r_22nm, Ron_10K, Vread, I_Tleak_22nm);
norm_kp_22nm_k10_Ron10K_r_22nm = kp_22nm_k10_Ron10K_r_22nm / k10; 
% Ron = 50K
Ron_50K = 50e3; %Ohm
kp_22nm_k10_Ron50K_r_22nm = kp_vs_Nr_complete(k10, Rt_22nm, Nr, r_22nm, Ron_50K, Vread, I_Tleak_22nm);
norm_kp_22nm_k10_Ron50K_r_22nm = kp_22nm_k10_Ron50K_r_22nm / k10; 
% Ron = 100K
Ron_100K = 100e3; %Ohm
kp_22nm_k10_Ron100K_r_22nm = kp_vs_Nr_complete(k10, Rt_22nm, Nr, r_22nm, Ron_100K, Vread, I_Tleak_22nm);
norm_kp_22nm_k10_Ron100K_r_22nm = kp_22nm_k10_Ron100K_r_22nm / k10; 
% plot
fig = figure();
fig.Position(3:4) = [400 420];
ax = gca;

P_10K = plot(Nr,norm_kp_22nm_k10_Ron10K_r_22nm, 'o-','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
hold on
P_50K = plot(Nr,norm_kp_22nm_k10_Ron50K_r_22nm, 's--','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880], 'MarkerFaceColor',[0.4660 0.6740 0.1880]);
P_100K = plot(Nr,norm_kp_22nm_k10_Ron100K_r_22nm, ':','Linewidth',1.5, 'Color',[0.4660 0.6740 0.1880]);
hold off

text(128, 0.61,{['$r =$ ', num2str(r_22nm), '$\Omega$'], ['$I_{Tleak}=$ ', num2str(I_Tleak_22nm*1e12), '$pA$'], ['$R_T =$ ', num2str(Rt_22nm/1e3), '$k\Omega$'], ['$k =$ ', num2str(k10)]},'interpreter','latex', 'FontSize',16);  %

set(gca,'linewidth',1.5,'fontsize',16);
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.2);
ylabel('Norm. margin $k''/k$', 'FontSize',22, 'Fontname','Times New Roman', 'interpreter','latex');
xlabel('Array size $N_r$','FontSize',20, 'Fontname','Times New Roman', 'interpreter','latex'); 
xlim([0,4200]);
set(gca,'XTick',[0, 1000, 2000, 3000, 4000]);
ylim([0.4,1.02]);
% set(gca, 'XScale', 'log')
% leg1=legend({['$k = $ ', num2str(k10)],['$k = $ ', num2str(k20)],['$k = $ ', num2str(k100)]}, 'interpreter','latex', 'Location','best');
% leg1=legend({['$k = $ ', num2str(k10)]}, 'interpreter','latex', 'Location','best');
% legend('boxoff')
ah2=axes('position',get(gca,'position'),'visible','off');
leg2 = legend(ah2, [P_10K, P_50K, P_100K],{['$R_{on} =$ ', num2str(Ron_10K/1e3), '$k\Omega$'],['$R_{on} =$ ', num2str(Ron_50K/1e3), '$k\Omega$'],['$R_{on} =$ ', num2str(Ron_100K/1e3), '$k\Omega$']},'interpreter','latex', 'Location', 'southeast','FontSize',14);
legend('boxoff')
ax.Color = 'none';

%%  r=2.5, sweep Ron, study the joint effect of transistor leakage I_Tleak + r in 22nm. In which R range that r palys a more important role compared to I_Tleak
% k = 10
r_22nm = 2.5;
I_Tleak_22nm =  40e-12; % 40pA , leakage of 22nm transtor approx. 22nm 
Nr_256 = 256;
Nr_1024 = 1024;
Nr_2048 = 2048;
Nr_4096 = 4096;
Ron_vec = [1e3,  2e3, 5e3, 1e4, 2e4, 5e4, 1e5, 2e5, 5e5, 1e6, 2e6, 5e6, 1e7, 5e7, 1e8];
% 256
kp_k10_Nr256 = kp_vs_Ron_complete(k10, Rt_22nm, Nr_256, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k10_Nr256 = kp_k10_Nr256 / k10; 
% 1024
kp_k10_Nr1024 = kp_vs_Ron_complete(k10, Rt_22nm, Nr_1024, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k10_Nr1024 = kp_k10_Nr1024 / k10; 
% 2048
kp_k10_Nr_2048 = kp_vs_Ron_complete(k10, Rt_22nm, Nr_2048, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k10_Nr_2048 = kp_k10_Nr_2048 / k10; 
% 4096
kp_k10_Nr_4096 = kp_vs_Ron_complete(k10, Rt_22nm, Nr_4096, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k10_Nr_4096 = kp_k10_Nr_4096 / k10; 
% plot
fig = figure();
fig.Position = [500, 200, 500, 520]; % [left, bottom, width, height], left and bottom define the location of the figure window on the screen. width and height define the size (in pixels) of the figure window.
ax = gca;

P_256  = plot(Ron_vec, norm_kp_k10_Nr256,   'o-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');
hold on
P_1024 = plot(Ron_vec, norm_kp_k10_Nr1024,  '^-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');
P_2048 = plot(Ron_vec, norm_kp_k10_Nr_2048, 'd-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');
% P_4096 = plot(Ron_vec, norm_kp_k10_Nr_4096, '*-','Linewidth',2, 'Color',[0.4660 0.6740 0.1880]);
P_4096 = plot(Ron_vec, norm_kp_k10_Nr_4096, 's-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');

% SPICE simulation results of Nr=1024
label_model_1024 = plot(Ron_vec, norm_kp_k10_Nr1024,  '-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');
P_spice_256  = plot(Ron_vec, Sp_norm_k10_Nr256_vec, 'o--','Linewidth',1.2, 'Color','r', 'MarkerSize', 5); % Sp_norm_k10_Nr256_vec
P_spice_1024 = plot(Ron_vec, Sp_norm_k10_Nr1024_vec, '^--','Linewidth',1.2, 'Color','r', 'MarkerSize', 5); % Sp_norm_k10_Nr1024_vec
label_spice_1024 = plot(Ron_vec, Sp_norm_k10_Nr1024_vec, '--','Linewidth',1.5, 'Color','r', 'MarkerSize', 5); % Sp_norm_k10_Nr1024_vec

hold off

text(5e3, 0.17,{['22nm node'],['$r =$ ', num2str(r_22nm), '$\Omega$'], ['$I_{Tleak}=$ ', num2str(I_Tleak_22nm*1e12), '$pA$'], ['$R_T =$ ', num2str(Rt_22nm/1e3), '$k\Omega$'], ['$k =$ ', num2str(k10)]},'interpreter','latex', 'FontSize',15);  %

set(gca,'linewidth',1.5,'fontsize',16);
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.2);
ylabel('Norm. margin $k''/k$', 'FontSize',22, 'Fontname','Times New Roman', 'interpreter','latex');
% ylabel('Norm. margin ', 'FontSize',22, 'Fontname','Arial');
xlabel('$R_{on} (\Omega)$','FontSize',20, 'Fontname','Times New Roman', 'interpreter','latex'); 
xlim([9e2, 1.2e8]);
set(gca,'XTick', [1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9]);
ylim([0,1.04]);
set(gca, 'XScale', 'log')
leg1=legend({['$N_r = $ ', num2str(Nr_256)], ['$N_r = $ ', num2str(Nr_1024)], ['$N_r = $ ', num2str(Nr_2048)], ['$N_r = $ ', num2str(Nr_4096)]}, 'interpreter','latex', 'Location','northeast');
legend('boxoff')
ah1=axes('position',get(gca,'position'),'visible','off');
leg2 = legend(ah1, [label_spice_1024, label_model_1024],{['Circuit sim.'], ['Model']},'interpreter','latex', 'Location', 'best','FontSize',15);
legend('boxoff')
ax.Color = 'none';

%% k = 100
% 256
kp_k100_Nr256 = kp_vs_Ron_complete(k100, Rt_22nm, Nr_256, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k100_Nr256 = kp_k100_Nr256 / k100; 
% 1024
kp_k100_Nr1024 = kp_vs_Ron_complete(k100, Rt_22nm, Nr_1024, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k100_Nr1024 = kp_k100_Nr1024 / k100; 
% 2048
kp_k100_Nr_2048 = kp_vs_Ron_complete(k100, Rt_22nm, Nr_2048, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k100_Nr_2048 = kp_k100_Nr_2048 / k100; 
% 4096
kp_k100_Nr_4096 = kp_vs_Ron_complete(k100, Rt_22nm, Nr_4096, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k100_Nr_4096 = kp_k100_Nr_4096 / k100; 
% plot
fig = figure();
fig.Position = [500, 200, 500, 520]; % [left, bottom, width, height], left and bottom define the location of the figure window on the screen. width and height define the size (in pixels) of the figure window.
ax = gca;

P_256  = plot(Ron_vec, norm_kp_k100_Nr256,   'o-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');
hold on
P_1024 = plot(Ron_vec, norm_kp_k100_Nr1024,  '^-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');
P_2048 = plot(Ron_vec, norm_kp_k100_Nr_2048, 'd-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');
P_4096 = plot(Ron_vec, norm_kp_k100_Nr_4096, 's-','Linewidth',2, 'Color','k', 'MarkerFaceColor','k');
hold off
text(2e6, 0.4,{['22nm node'],['$r =$ ', num2str(r_22nm), '$\Omega$'], ['$I_{Tleak}=$ ', num2str(I_Tleak_22nm*1e12), '$pA$'], ['$R_T =$ ', num2str(Rt_22nm/1e3), '$k\Omega$'], ['$k =$ ', num2str(k100)]},'interpreter','latex', 'FontSize',15);  %

set(gca,'linewidth',1.5,'fontsize',16);
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.2);
ylabel('Norm. margin $k''/k$', 'FontSize',22, 'Fontname','Times New Roman', 'interpreter','latex');
% ylabel('Norm. margin ', 'FontSize',22, 'Fontname','Arial');
xlabel('$R_{on} (\Omega)$','FontSize',20, 'Fontname','Times New Roman', 'interpreter','latex'); 
xlim([9e2, 1.2e8]);
set(gca,'XTick', [1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9]);
ylim([0,1.04]);
set(gca, 'XScale', 'log')
leg1=legend({['$N_r = $ ', num2str(Nr_256)], ['$N_r = $ ', num2str(Nr_1024)], ['$N_r = $ ', num2str(Nr_2048)], ['$N_r = $ ', num2str(Nr_4096)]}, 'interpreter','latex', 'Location','northeast');
legend('boxoff')
ax.Color = 'none';

%%  r=2.5 and 5, I_Tleak = 40 and 80pA, sweep Ron, study the joint effect of transistor leakage I_Tleak + r when technology scales down
Vread = 0.2; % Volt
r_22nm = 2.5;
r_0 = 0;
Rt_0 = 0;

I_Tleak_22nm =  40e-12; % 40pA , leakage of 22nm transtor approx. 22nm 
I_Tleak_0 =  0;

Nr = 1024;
Ron_vec = [1e3,  2e3, 5e3, 1e4, 2e4, 5e4, 1e5, 2e5, 5e5, 1e6, 2e6, 5e6, 1e7, 5e7, 1e8, 5e8, 1e9];
% 22nm complete model
kp_k10_22nm = kp_vs_Ron_complete(k10, Rt_22nm, Nr, r_22nm, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k10_22nm = kp_k10_22nm / k10; 
% without Tleak
kp_k10_r22nm_leak0 = kp_vs_Ron_complete(k10, Rt_22nm, Nr, r_22nm, Ron_vec, Vread, I_Tleak_0);  % Ron is a vector
norm_kp_k10_r22nm_leak0 = kp_k10_r22nm_leak0 / k10; 
% without Tleak & Rt
kp_k10_r22nm_Rt0_leak0 = kp_vs_Ron_complete(k10, Rt_0, Nr, r_22nm, Ron_vec, Vread, I_Tleak_0);  % Ron is a vector
norm_kp_k10_r22nm_Rt0_leak0 = kp_k10_r22nm_Rt0_leak0 / k10; 
% without r
kp_k10_r0_leak22nm = kp_vs_Ron_complete(k10, Rt_22nm, Nr, r_0, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k10_r0_leak22nm = kp_k10_r0_leak22nm / k10; 
% without Rt and r, Rt is transistor resistance
kp_k10_r0_Rt0_leak22nm = kp_vs_Ron_complete(k10, Rt_0, Nr, r_0, Ron_vec, Vread, I_Tleak_22nm);  % Ron is a vector
norm_kp_k10_r0_Rt0_leak22nm = kp_k10_r0_Rt0_leak22nm / k10; 

% plot
fig = figure();
fig.Position = [500, 200, 500, 520]; % [left, bottom, width, height], left and bottom define the location of the figure window on the screen. width and height define the size (in pixels) of the figure window.
ax = gca;

plot(Ron_vec, norm_kp_k10_22nm, 'o-','Linewidth', 2, 'Color','k', 'MarkerFaceColor','k');
hold on
plot(Ron_vec, norm_kp_k10_r22nm_leak0, '-','Linewidth', 2, 'Color','k', 'MarkerFaceColor','k');      % Tleak = 0
plot(Ron_vec, norm_kp_k10_r0_leak22nm, ':','Linewidth', 2, 'Color','k', 'MarkerFaceColor','k');      % r = 0
plot(Ron_vec, norm_kp_k10_r0_Rt0_leak22nm, '--','Linewidth', 2, 'Color','k', 'MarkerFaceColor','k'); % r = 0, Rt = 0
hold off

% text(7e3, 0.45,{['22nm node'], ['$k =$ ', num2str(k10)], ['$N_r =$ ', num2str(Nr)]},'interpreter','latex', 'FontSize',15);  %

set(gca,'linewidth',1.5,'fontsize',16);
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.2);
ylabel('Norm. margin $k''/k$', 'FontSize',22, 'Fontname','Times New Roman', 'interpreter','latex');
xlabel('$R_{on} (\Omega)$','FontSize',20, 'Fontname','Times New Roman', 'interpreter','latex'); 
xlim([9e2, 1.2e8]);
set(gca,'XTick', [1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9]);
ylim([0,1.04]);
set(gca, 'XScale', 'log')
leg1=legend({['Complete model'], ['$wo/$',' $T_{leak}$ '], ['$wo/$',' $r$ '], ['$wo/$',' ', '$r$ ', '\&', ' $R_T$']}, 'interpreter','latex', 'Location','southwest', 'FontSize',16);

legend('boxoff')
ax.Color = 'none';


%% Effect of Vread
fig = figure();
fig.Position = [500, 200, 500, 520]; % [left, bottom, width, height], left and bottom define the location of the figure window on the screen. width and height define the size (in pixels) of the figure window.
ax = gca;

Vread_04 = 0.4; % Volt
I_Tleak_22nm_Vr04 = 55e-12;  % trans simulation, vs DC simulation: 42pA 
kp_k10_22nm_Vr04 = kp_vs_Ron_complete(k10, Rt_22nm, Nr, r_22nm, Ron_vec, Vread_04, I_Tleak_22nm_Vr04);  % Ron is a vector
norm_kp_k10_22nm_Vr04 = kp_k10_22nm_Vr04 / k10; 

Vread_06 = 0.6; % Volt
I_Tleak_22nm_Vr06 = 74e-12;  % trans simulation, vs DC simulation: 48pA 
kp_k10_22nm_Vr06 = kp_vs_Ron_complete(k10, Rt_22nm, Nr, r_22nm, Ron_vec, Vread_06, I_Tleak_22nm_Vr06);  % Ron is a vector
norm_kp_k10_22nm_Vr06 = kp_k10_22nm_Vr06 / k10; 

% 22nm
plot(Ron_vec, norm_kp_k10_22nm, '-','Linewidth', 2, 'Color','k', 'MarkerFaceColor','k');
hold on
plot(Ron_vec, norm_kp_k10_22nm_Vr04, '--','Linewidth', 2, 'Color',[0 0.4470 0.7410], 'MarkerFaceColor',[0 0.4470 0.7410]);
plot(Ron_vec, norm_kp_k10_22nm_Vr06, '--','Linewidth', 2, 'Color',[0.8500 0.3250 0.0980], 'MarkerFaceColor',[0.8500 0.3250 0.0980]);
plot(Ron_vec, norm_kp_k10_22nm_Vr04 - norm_kp_k10_22nm, ':','Linewidth', 2, 'Color',[0 0.4470 0.7410], 'MarkerFaceColor',[0 0.4470 0.7410]);
plot(Ron_vec, norm_kp_k10_22nm_Vr06 - norm_kp_k10_22nm, ':','Linewidth', 2, 'Color',[0.8500 0.3250 0.0980], 'MarkerFaceColor',[0.8500 0.3250 0.0980]);
hold off
text(1e4, 0.6,{'22nm node'},'interpreter','latex', 'FontSize',16);  %
text(1e3, 0.95,{'Trade-off: $Power \propto V^2/R$'},'interpreter','latex', 'FontSize',16);  %

set(gca,'linewidth',1.5,'fontsize',16);
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',0.2);
ylabel('Norm. margin $k''/k$', 'FontSize',22, 'Fontname','Times New Roman', 'interpreter','latex');
xlabel('$R_{on} (\Omega)$','FontSize',20, 'Fontname','Times New Roman', 'interpreter','latex'); 
xlim([9e2, 1.2e8]);
set(gca,'XTick', [1e3, 1e4, 1e5, 1e6, 1e7, 1e8, 1e9]);
ylim([0,1.04]);
set(gca, 'XScale', 'log')
leg1=legend({'$V_{read}=0.2V$', '$V_{read}=0.4V$', '$V_{read}=0.6V$', 'Improvement'}, 'interpreter','latex', 'Location','southwest', 'FontSize',16);

legend('boxoff')
ax.Color = 'none';





%% The relationship between k' and k: 
%% The model does not include transistor leakage, in TCAS-II paper "Scaling Limits of Memristor-Based Routers for Asynchronous Neuromorphic Systems"
function k_prime = k_p_vs_Nr(k, Rt, n, r, Ron) 
    len_n = size(n, 2);
    for i = 1:len_n
        n(i)
        k_prime(i) = (k - 1)/(1+((Rt + n(i)*r)/Ron)) + 1; % in TCAS-II paper "Scaling Limits of Memristor-Based Routers for Asynchronous Neuromorphic Systems"
    end
end

% To validate if the equation above is typed correctly or not.
function k_prime = k_p_vs_Nr_validate(k, Rt, n, r, Ron)
    len_n = size(n, 2);
    for i = 1:len_n
        k_prime(i) = (Ron*k + Rt + n(i)*r)/(Ron + Rt + n(i)*r); % in TCAS-II paper "Scaling Limits of Memristor-Based Routers for Asynchronous Neuromorphic Systems"
    end
end

%% The model includes transistor leakage, in ISCAS 2025 paper "Scaling Effects of Transistor Leakage Current and IR Drop on 1T1R Memory Arrays"
% Compete equation. I_Tleak is the leakage current of one transistor
function k_prime = kp_vs_Nr_complete(k, Rt, n, r, Ron, Vread, I_Tleak)   % n is a vector. Sweep the size of the array.
    len_n = size(n, 2);
    for i = 1:len_n
        k_prime(i) = (Vread/(Ron + Rt + n(i)*r) + (n(i)-1)*I_Tleak) / (Vread/(k*Ron + Rt + n(i)*r) + (n(i)-1)*I_Tleak); 
    end
end

% Compete equation. I_Tleak is the leakage current of one transistor
function k_prime = kp_vs_Ron_complete(k, Rt, n, r, Ron, Vread, I_Tleak)  % Ron is a vector. Sweep Ron.
    len_Ron = size(Ron, 2);
    for i = 1:len_Ron
        k_prime(i) = (Vread/(Ron(i) + Rt + n*r) + (n-1)*I_Tleak) / (Vread/(k*Ron(i) + Rt + n*r) + (n-1)*I_Tleak); 
    end
end

% % Sweep r, fixed n, not used in the ISCAS paper
% function k_prime = kp_vs_Nr_sweep_r(k, Rt, n, r, Ron)
%     len_r = size(r, 2);
%     for i = 1:len_r
%         r(i)
%         k_prime(i) = (k - 1)/(1+((Rt + n*r(i))/Ron)) + 1; 
%     end
% end




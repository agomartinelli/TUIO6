% This function initializes the system with symbolic state variables, input fields, and outputs. 
% The user should modify the lines where syms, sys.x, sys.g0, sys.g, and sys.hobs are defined to adapt the system to 
% their specific case.
function sys = initialize_system()
syms St real%This is the variable time. 
%For a TV system, you can use St to define the dynamics (sys.g0 and sys.g) and/or the outputs (sys.hobs)


    



%================================
%HIV model

syms STu STi SV Sla Sr Sd SN Sc real

sys.x=[STu STi SV Sla Sr Sd SN Sc]';

zeri=zeros(1,5);
sys.g0=[Sla-Sr*STu, -Sd*STi, SN*Sd*STi-Sc*SV, zeri]';
sys.g(:,1)=[-STu*SV, STu*SV, 0, zeri]';

sys.hobs=[SV, STu+STi];
%================================


% % % %================================
% % % %Toggle SWITCH model
% % % syms Sx1 Sx2 SG1 SG2 Sk01 Sk02 Sk1 Sk2 Sa Sb real
% % % sys.x=[Sx1 Sx2 SG1 SG2 Sk01 Sk02 Sk1 Sk2 Sa Sb]';
% % % 
% % % zeri=zeros(1,6);
% % % sys.g0=[Sk01+Sk1/(1+(Sx2/SG1)^Sa)-Sx1,Sk02+Sk2/(1+(Sx1/SG2)^Sb)-Sx2,0,0,zeri]';
% % % sys.g(:,1)=[0, 0, sym(1), 0, zeri]';
% % % sys.g(:,2)=[0, 0, 0, sym(1), zeri]';
% % % sys.hobs=[Sx1, Sx2];
% % % %================================

% % % %================================
% % % %%%CASE STUDY TAC 2025
% % % syms Sx1 Sx2 Sx3 Sx4 Sx5 real
% % % 
% % % sys.x=[Sx1 Sx2 Sx3 Sx4 Sx5]';
% % % 
% % % 
% % % sys.g0=[Sx3 Sx5 0 0 0]';
% % % sys.g(:,1)=[0 1 Sx4 0 0]';
% % % sys.g(:,2)=[0 1 Sx4 Sx4 Sx5]';
% % % 
% % % sys.hobs=[Sx1 Sx2];
% % % 
% % % sys.deg=0;
% % % sys.ht=[];
% % % %================================

% % % %================================
% % % %%%OLD CASE STUDY TAC 2025
% % % syms Sx1 Sx2 Sx3 Sx4 Sx5 Sx6 Sx7 Sx8 real
% % % 
% % % sys.x=[Sx1 Sx2 Sx3 Sx4 Sx5 Sx6 Sx7 Sx8]';
% % % 
% % % 
% % % sys.g0=[Sx3 0 0 0 0 Sx8 0 Sx4*Sx5*Sx6]';
% % % sys.g(:,1)=[Sx1 Sx7/Sx2 1 0 Sx4 Sx6 0 Sx7]';
% % % sys.g(:,2)=[Sx2 Sx7/Sx1 1/Sx1 Sx2/Sx3 0 0 Sx6 Sx2]';
% % % sys.g(:,3)=[0 0 0 Sx5 1 0 0 0]';
% % % 
% % % sys.hobs=[Sx1 Sx2 Sx3];
% % % 
% % % sys.deg=0;
% % % sys.ht=[];
% % % %================================


% % % %================================
% % % %TIME VARIANT SYSTEM
% % % 
% % % syms x1 x2 real
% % % 
% % % sys.x=[x1 x2]';
% % % 
% % % sys.g0=[sym(1) 0]';
% % % sys.g(:,1)=[0 sym(1)]';
% % % 
% % % sys.hobs=[x1+St*x2];
% % % %================================


% % % %================================
% % % %TIME VARIANT SYSTEM
% % % 
% % % syms x1 x2 real
% % % 
% % % sys.x=[x1 x2]';
% % % 
% % % sys.g0=[cos(St) sym(1)]';
% % % sys.g(:,1)=[0 St]';
% % % 
% % % sys.hobs=[cos(x1+St*x2)];
% % % %================================



% % % %================================
% % % %TRIVIAL
% % % 
% % % syms x1 x2 real
% % % 
% % % sys.x=[x1 x2]';
% % % 
% % % sys.g0=[x2 0]';
% % % sys.g(:,1)=[0 sym(1)]';
% % % 
% % % sys.hobs=[x1];
% % % %================================



% % % %================================
% % % % CASE STUDY
% % % syms Sx1 Sx2 Sx3 Sx4 Sx5 Sx6 Sx7 Sx8 real
% % % 
% % % sys.x=[Sx1 Sx2 Sx3 Sx4 Sx5 Sx6 Sx7 Sx8]';
% % % 
% % % sys.g0=[Sx3 0 0 0 0 exp(Sx8) 0 cos(Sx4)*Sx5*Sx6]';
% % % sys.g(:,1)=[Sx1 Sx7/Sx2 sym(1) 0 Sx4 Sx6 0 Sx7]';
% % % sys.g(:,2)=[Sx2 Sx7/Sx1 sym(1)/Sx1 Sx2/Sx3 0 0 Sx6 Sx2]';
% % % sys.g(:,3)=[0 0 0 Sx5 sym(1) 0 0 0]';
% % % 
% % % sys.hobs=[Sx1 Sx2 Sx3];
% % % %================================






    % Initialize other system parameters
    sys.deg = 0;
    sys.ht = [];
    sys.time = St;


    [n, m_w] = size(sys.g); 
    sys.n = length(sys.x);
    sys.m_w = m_w; 

end

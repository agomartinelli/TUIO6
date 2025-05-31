clear all
clc


sys = initialize_system();% This function must be adapted by modifying the corresponding sections to fit your specific system.

sys = set_tool(sys);

if sys.m_w == 0
    Continue = false;
    ContinueAfter = false;
    disp('No UI')
    [OBS, iter] = CodInvF(sys.x, sys.g0, sys.hobs);
    sys.hobs = OBS.h;
    sys.O = OBS.O;
    sys.OE = OBS.OE;
    if length(sys.hobs) == sys.n
        disp('State Observable')
    else
        disp('State Unobservable')
    end
else
    Continue = true;
    ContinueAfter = true;
    [sys] = ComputeDegreeReconstructabilityAndReorder(sys);
end


% ContinueAfter = false;

% bloccaperdebug = 0;
while Continue
%     bloccaperdebug = bloccaperdebug + 1;
    disp('MAIN LOOP')
    
    %Initializes the observability cod to the span of the differentials of the observable functions which are available
    [OBS, iter] = CodInvF(sys, [], sys.hobs);
    sys = UpdateSysWithObs(sys, OBS);

    if sys.deg == sys.m_w
        disp('System in Canonic form')
        break
    end
    
    disp('Canonization')
    [MU, NU] = ComputeMu(sys);
    ghat = ComputeGhat(sys, NU);
    Gkhat = ComputeGkhat(sys, ghat);
    [Finish, sys, ord, theta] = Algorithm2(sys, ghat, Gkhat);
    
    if Finish
        disp('Convergence')
        sys
        Continue = false;
        ContinueAfter = false;
        break
    else
        m = sys.deg;
        n = sys.n;
        if m == 0
%             sys
%             ghat
%             Gkhat
%             sys.hobs
            [OBS, iter] = CodInvF1ifF2(sys, ghat, Gkhat, sys.hobs);
            sys = UpdateSysWithObs(sys, OBS);
        else
            sys = UIE(sys, ghat, Gkhat, theta, ord);
        end
        [sys] = ComputeDegreeReconstructabilityAndReorder(sys);
        sys = ResetName(sys, n);
        sys.n = length(sys.x);
    end
end

if ContinueAfter
    disp('Procedure with Canonic System')
    if length(sys.hobs) == sys.n
        disp('State Observable')
    else
        [MU, NU] = ComputeMu(sys);
        [ghat] = ComputeGhat(sys, NU);
        [OBS, iter] = CodInvF(sys, ghat, sys.hobs);
        sys = UpdateSysWithObs(sys, OBS);
        if length(sys.hobs) == sys.n
            disp('State Observable')
        else
            disp('State Unobservable')
        end
    end
end



function [Finish, sysS, ord, theta] = Algorithm2(sys, ghat, Gkhat)
    % If Finish=true, then sysS is an updated version of sys containing the full 
    % observability codistribution (OBS). In this case, ord is the maximum order of 
    % Lie derivatives in OBS (this is of little importance) and theta is not used.
    % If Finish=false, sysS is identical to sys, ord is the order of Lie derivatives 
    % used to calculate the new UI identifier, and theta is the generator in sys.O 
    % where the Lie derivatives are calculated to generate the UI identifier 
    % (this is done in the main function and is called thetav).

    sysS = sys;  % Copy the system to sysS

    % Check if Gkhat vanishes (i.e., the system is in canonical form)
    CondGkhatVanish = EvaluateRandom(simplify(Gkhat), sys);
    CondGkhatVanish = sum(sum(abs(CondGkhatVanish)));
    
    if (CondGkhatVanish < sys.tool.zero)
        Finish = true;
        [OBS, iter] = CodInvF(sys, ghat, sys.hobs);
        sysS.O = OBS.O;
        sysS.OE = OBS.OE;
        sysS.hobs = OBS.h;
        ord = iter - 1;
        theta = [];
        return;
    end

    % Initialize variables for the system's state and observability
    x = sys.x;
    t = sys.time;
    [n, my] = size(ghat);
%     sys.n
%     sys.deg +1
    ri = length(sys.hobs);
    
    hobs = sys.hobs;
    O = sys.O;
    OE = sys.OE;
    Radice = (1:ri);
    
    NgenOld = 0;
    Ngen = ri;
    ord = 0;
    
    % Loop until the rank of the system stabilizes
    while (Ngen > NgenOld)
        for igen = NgenOld + 1:Ngen
            % Check the condition for the Lie derivative
            Cond = EvaluateRandom(simplify(O(igen, :) * Gkhat), sys);
            Cond = sum(abs(Cond));
            if (Cond > sys.tool.zero)  % If condition is met
                Finish = false;
                sysS = sys;
                theta = sys.hobs(Radice(igen));
                return;
            else
                for iu = 1:my
                    riOld = ri;
                    h = O(igen, :) * ghat(:, iu);
                    if iu==1
                        h=h+diff(hobs(igen),t);
                    end
                    Oi = jacobian(h, x);
                    OiE = EvaluateRandom(Oi, sys);
                    TOL = sys.tool.cTOL * max(size([OE; OiE])) * eps(norm([OE; OiE]));
                    ri = rank([OE; OiE], TOL);
                    if ri > riOld
                        O = [O; Oi];
                        OE = [OE; OiE];
                        hobs = [hobs, h];
                        Radice(ri) = Radice(igen);
                        if ri == n
                            igen = Ngen + 1;  % Stop the loop when full rank is achieved
                            break;
                        end
                    end
                end
            end
        end
        NgenOld = Ngen;
        Ngen = ri;
        ord = ord + 1;
    end

    Finish = true;
    sysS.O = O;
    sysS.OE = OE;
    sysS.hobs = hobs;
    theta = [];
    return;
end

function sys = UpdateSysWithObs(sys, OBS)
    % Updates the system structure with the observability codistribution
    % and th enew observable functions
    
    sys.hobs = OBS.h;
    sys.O = OBS.O;
    sys.OE = OBS.OE;
end

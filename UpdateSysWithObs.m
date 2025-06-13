function sys = UpdateSysWithObs(sys, OBS)
    % Updates the system structure with the observability codistribution
    % and the new observable functions
    
    sys.hobs = OBS.h;
    sys.O = OBS.O;
    sys.OE = OBS.OE;
end

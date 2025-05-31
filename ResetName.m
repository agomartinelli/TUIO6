function sysS = ResetName(sys, n)
    % This function renames the state variables of the system starting from index n+1.
    % The state variables from n+1 to N are renamed to symbolic variables 
    % ('Sx(n+1)', 'Sx(n+2)', ..., 'SxN') and the related fields are updated accordingly.
    
    sysS = sys;
    x = sys.x;
    O = sys.O;
    hobs = sys.hobs;
    g0 = sys.g0;
    g = sys.g;
    ht = sys.ht;
    
    N = length(sys.x);  % Total number of state variables
    Sx = 'Sx';  % Prefix for new state variables
    
    for i = n+1:N
        is = num2str(i);  % Create symbolic variable name (e.g., 'Sx(n+1)', 'Sx(n+2)')
        s = strcat('Sx', is);
        w = sym(s, 'real');  % Define symbolic variable
        
        % Substitute the old variable with the new symbolic variable in all related expressions
        x = subs(x, sys.x(i), w);
        O = subs(O, sys.x(i), w);
        hobs = subs(hobs, sys.x(i), w);
        g0 = subs(g0, sys.x(i), w);
        g = subs(g, sys.x(i), w);
        ht = subs(ht, sys.x(i), w);
    end
    
    % Update the system structure with the new renamed variables
    sysS.x = x;
    sysS.O = O;
    sysS.hobs = hobs;
    sysS.g0 = g0;
    sysS.g = g;
    sysS.ht = ht;
end
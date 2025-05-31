function sys = set_tool(sys)
    % Set tool parameters and initialize necessary variables

    % Initialize the state estimate vector 'xe' with random values
    % The vector size is (n + 10 * m_w), where 'n' is the number of states and 'm_w' is the number of unknown inputs
    % 'xe' will later be used for rank calculations in the subsequent steps
    sys.tool.xe = rand(sys.n + 1 + 10 * sys.m_w, 1);

    % Set the tolerance value for the tool (used in various computations)
    sys.tool.cTOL = 1e5;

    % Set the zero threshold value (used to consider small values as zero)
    sys.tool.zero = 1e-10;
end


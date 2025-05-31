function [sys] = ComputeDegreeReconstructabilityAndReorder(sys)
%     Computes the degree of reconstructability and reorders system UIs 
%     based on the rank of the reconstructability matrix.

    h = sys.hobs;
    g = sys.g;
    x = sys.x;
    m_w = sys.m_w;
    mOld = sys.deg;
    
    p = length(h);

    % Compute the reconstructability matrix and its random evaluation
    RM = RecMat(x, g, h);
    RME = EvaluateRandom(RM, sys);
    
    % Calculate tolerance and rank
    TOL = sys.tool.cTOL * max(size(RME)) * eps(norm(RME));
    m = rank(RME, TOL);

    % If degree has changed, reorder UIs and update
    if m ~= mOld
        [idc, idr] = ExtractFullRank(RME, m);
        idrc = (1:p); idrc(idr) = [];
        idcc = (1:m_w); idcc(idc) = [];
        
        ht = h(idr);
        ht = reshape(ht, [1, length(ht)]);
        hadd = h(idrc);
        hadd = reshape(hadd, [1, length(hadd)]);
        g = [g(:, idc), g(:, idcc)];

        % Update system structure
        sys.g = g;
        sys.ht = ht;
        sys.deg = m;
    end
end

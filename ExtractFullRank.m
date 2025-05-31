function [idc, idr] = ExtractFullRank(X, m)

    [Q, R, idc] = qr(X, 'vector');
    [Q, R, idr] = qr(X', 'vector');
    idc = idc(1:m);
    idc = sort(idc);
    idr = idr(1:m);
    idr = sort(idr);
    return


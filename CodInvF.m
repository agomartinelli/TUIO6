% This function calculates the codistribution, which contains the differentials of the components of h (differentials 
% calculated with respect to the state sys.x) and which is invariant with respect to the Lie derivatives along the vector 
% fields defined by the columns of F
function [OBS, iter] = CodInvF(sys, F, h)

x=sys.x;
t=sys.time;
[n,m]=size(F);
p=length(h);

hobs=[];
O=[];
OE=[];
iter=0;
ri=0;
for i=1:p
    riOld=ri;
    Oi=jacobian(h(i),x);
    OiE=EvaluateRandom(Oi,sys);
    TOL=sys.tool.cTOL*max(size([OE;OiE])) * eps(norm([OE;OiE]));
    ri=rank([OE;OiE],TOL);
    if ri>riOld
        O=[O;Oi];
        OE=[OE;OiE];
        hobs=[hobs, h(i)];
        if ri==n
            OBS.O=O;
            OBS.OE=OE;
            OBS.h=hobs;
            return;
        end
    end
end





NgenOld=0;
Ngen=ri;
while(Ngen>NgenOld)
    iter=iter+1;
    for igen=NgenOld+1:Ngen
        for iu=1:m
            riOld=ri;
            h=O(igen,:)*F(:,iu);
            if iu==1
                h=h+diff(hobs(igen),t);
            end
            Oi=jacobian(h,x);
            OiE=EvaluateRandom(Oi,sys);
            TOL=sys.tool.cTOL*max(size([OE;OiE])) * eps(norm([OE;OiE]));
            ri=rank([OE;OiE],TOL);
            if ri>riOld
                O=[O;Oi];
                OE=[OE;OiE];
                hobs=[hobs, h];
                if ri==n
                    OBS.O=O;
                    OBS.OE=OE;
                    OBS.h=hobs;
                    return;
                end
            end
        end
    end
    NgenOld=Ngen;
    Ngen=ri;
end


OBS.O=O;
OBS.OE=OE;
OBS.h=hobs;
return
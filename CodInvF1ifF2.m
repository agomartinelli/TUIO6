% <F1 \frac{F2}{F3}, \nabla h>
function [OBS, iter] = CodInvF1ifF2(sys, F1, F2, h)

x=sys.x;
t=sys.time;
[n,m1]=size(F1);
[n,m2]=size(F2);
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
        include=1;
        for i2=1:m2
            h=O(igen,:)*F2(:,i2);
            hnum=EvaluateRandom(h,sys);
            if abs(hnum)>sys.tool.zero
                include=0;
                break
            end
        end
        if include==1
            for i1=1:m1
                riOld=ri;
                h=O(igen,:)*F1(:,i1);
                if i1==1
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
    end
    NgenOld=Ngen;
    Ngen=ri;
end

OBS.O=O;
OBS.OE=OE;
OBS.h=hobs;

return
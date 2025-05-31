function sysS = UIE(sys, ghat, Gkhat, theta, ord)

[n,m]=size(ghat);
m=m-1;



Zm=zeros(m,1);
Ghat=ghat(:,1);
for iord=0:ord
    if iord==0
        sord='';
    else
        sord=strcat('_',num2str(iord));
    end
    for j=1:m
        js=num2str(j);
        s=strcat('v',js,sord);
        w = sym(s,'real');
        sys.x=[sys.x;w];
        if iord==0
            Ghat=Ghat+w*ghat(:,j+1);
        else
            Ghat=[Ghat;w];
        end
    end
end
Ghat=[Ghat;Zm];
N=length(sys.x);
g=sys.x(1)*zeros(N,m);
thetav=theta;
for iord=1:ord
    thetav=LieDer(Ghat, thetav, sys.x)+diff(thetav,sys.time);
end


vNonInTheta=[];
IndexDelete=[];
for j=1:m
    for iord=ord:-1:0
        i=n+m*iord+j;
        con=jacobian(thetav,sys.x(i));
        con=abs(EvaluateRandom(con,sys));
        if(con>0)
            Ghat(i)=0;
            g(i,j)=1;
            break;
        else
            if iord==0
                vNonInTheta=[vNonInTheta,j];
            end
            IndexDelete=[IndexDelete,i];
        end
    end
end
for ji=1:length(vNonInTheta)
    j=vNonInTheta(ji);
    vj=sys.x(n+j);
    Ghat(1:n)=Ghat(1:n)-vj*ghat(:,j+1);
    g(1:n,j)=ghat(:,j+1);
end

sys.x(IndexDelete)=[];
g(IndexDelete,:)=[];
Ghat(IndexDelete)=[];
N=length(sys.x);

hAdd=[sys.x(n+1:end);thetav];
OAdd=jacobian(hAdd,sys.x);
OAddE=EvaluateRandom(OAdd,sys);

[r,c]=size(sys.O);
zrd=zeros(r,N-n);
O=[sys.O,sys.x(1)*zrd];
OE=[sys.OE,zrd];

[r,c]=size(Gkhat);
Gkhat=[Gkhat;zeros(N-n,c)];


% sysS.m_w=sys.m_w;
% sysS.x=sys.x;
% sysS.time=sys.time;
% sysS.O=[O;OAdd];
% sysS.OE=[OE;OAddE];
% sysS.hobs=[sys.hobs, hAdd'];
% sysS.g0=Ghat;
% sysS.g=[g,Gkhat];
% sysS.deg=0;
% sysS.tool=sys.tool;

sysS=sys;
sysS.O=[O;OAdd];
sysS.OE=[OE;OAddE];
sysS.hobs=[sys.hobs, hAdd'];
sysS.g0=Ghat;
sysS.g=[g,Gkhat];
sysS.deg=0;

end


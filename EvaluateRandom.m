function WE = EvaluateRandom(W, sys)

x = sys.x;
t = sys.time;
n = length(x);
WE = double(subs(W, [t; x], sys.tool.xe(1:n+1)));

return

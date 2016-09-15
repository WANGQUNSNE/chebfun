function g = gammaFun(j, k)
%GAMMAFUN   Get a function handle to a gamma function.
%   G = GAMMAFUN(J, K) returns a function handle to the gamma function (J, K).
%
% See also SPINSCHEME/GAMMAEVAL.

% Copyright 2016 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Trivial case:
if ( j == 0 )
    g = @(z) (exp(k*z) - 1)./z;
    
% Compute them recursively using the recurrence formula:
elseif ( j == 1 )
    if ( k == 0 ) 
        g = @(z) ((exp(k*z) - 1)./z)./z;
    elseif ( k == 1 )
        g = @(z) ((exp(k*z) - 1)./z - 1)./z;
    end
else
    g = @(z) 0*z;
    for m = 1:j
        gm = spinscheme.gammaFun(j-m, k);
        g = @(z) g(z) + (-1)^(m-1)/m*gm(z);
    end
    if ( j <= k )
        g = @(z) (g(z) - nchoosek(k, j))./z;
    else
        g = @(z) g(z)./z;
    end
end

end
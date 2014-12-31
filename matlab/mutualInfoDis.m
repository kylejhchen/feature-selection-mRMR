% feature-selection-mRMR
% Created by Jiahong K. Chen

% Input: x, y two vector of discrete data
% Output: I(x,y) = mutual information of x and y

function mi = mutualInfoDis(x, y)

n       = length(x);

% reshape x and y into column vector
x       = x(:);
y       = y(:);

% shift x and y to 1:max([x;y])
lo      = min( [ x; y ] );
x       = x - lo + 1;
y       = y - lo + 1;
up      = max( [ x; y ] );

% negative Joint entropy
idx     = (1:n);
tabX    = sparse(idx, x, 1, n, up, n);
tabY    = sparse(idx, y, 1, n, up, n);
Pxy     = nonzeros(tabX'*tabY) / n;
negHxy  = Pxy' * log(Pxy);

% negative Entropy
Px      = mean(tabX);
Py      = mean(tabY);
negHx   = Px * log(Px)';
negHy   = Py * log(Py)';

% Mutual information
mi      = negHxy - negHx - negHy;
mi      = mi/log(2);

end
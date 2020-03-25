function X_transform = normalize(X, method)

d = size(X, 1);
% ÿ��2����Ϊ1
if strcmp(method, 'L2')
    X_transform  =  X ./ repmat(sqrt(sum(X.*X)), [d,1]);
end

% ÿ���һ����[0,1]
if strcmp(method, 'MinMax')
    X_transform = rescale(X, 'InputMin', min(X), 'InputMax', max(X));
end

% ÿ�������Ϊ1
if strcmp(method, 'Inf')
    X_transform = X ./ max(abs(X));
end

end
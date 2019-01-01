clear
clc

%% �����ĳ�ʼ��
% A ��СΪ $(n_1,n_2,n_3)$��B ��СΪ $(n_2,l,n_3)$,
% 
% $R=A\times B$��R �Ĵ�СΪ $(n_2,l,n_3)$
%
n1 = 48;  % 48��
n2 = 580;  % 580��
n3 = 42;  % 42��
l = n2;
img_size = [n1, n2, n3];
A = rand(img_size);
B = rand(n2, l, n3);
times = 1; % �ظ��������

%% �����˷��������
tic
n = 0;
while n<times
    circA = circ(A);
    MatVecB = MatVec(B);
    temp = circA*MatVecB;
    r = fold(temp, n1, n3);
    n = n+1;
end
disp('ʹ�������˷��Ķ�������ʱ��');
toc

%% ���ٸ���Ҷ�任��������
tic
n = 0;
while n<times
    FFT = zeros(n1, l, n3);
    X = fft(A, [], 3);
    Y = fft(B, [], 3);
    for i=1:n3 
        FFT(:,:,i) = X(:,:,i)*Y(:,:,i);
    end
    Lb = ifft(FFT, [], 3);
    n = n+1;
end
disp('ʹ�ÿ��ٸ���Ҷ�任���������ʱ��');
toc

%% ����������ѭ������
function [circM]=circ(M)
    [x, y, z] = size(M);
    circM = zeros(x*z, y*z);
    index = gallery('circul',1:z)';
    for i=1:z
        for j=1:z
            slice = index(i,j);
            frontalSlice = M(:,:,slice);
            circM((i-1)*x+1:i*x, (j-1)*y+1:j*y) = frontalSlice;
        end
    end
end

%% ����������������ʽ����
function [MatVecM]=MatVec(M)
    [x, y, z] = size(M);
    MatVecM = zeros(x*z, y);
    for i=1:z
        MatVecM((i-1)*x+1:i*x, :) = M(:,:,i);
    end
end

%% �ָ�������ʽ
function t = fold(M, x, z)
for i=1:z
    value = M((i-1)*x+1:i*x, :);
    t(:,:,i) = value; %#ok<AGROW>
end
end
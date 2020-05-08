%%%%NMF%%%%%%%%%%%%
%%%%Communtiy discovery using nonnegative matrix factorization
%%%%min||G-XX'||_F^2, X>=0  min 0.5*||Xs - W*Hs*W'||^2 + 0.5 *||Xu - W*Hu*W'||^2 + beta*trace(W'*L*W) + gama*L1_norm 
%%%%K: community number
%%%%n: node number
%%%%G: Adj matrix
%% load文件夹data中的真实数据格式，网络和真实划分是两个分开的文件，网络是边表形式，划分为向量形式
load('.\X1.mat');%最佳X

[G,Adjz,Adjf]=EdgeToAdj(M);
Gz = Adjz;
Gf = Adjf;
n=size(G,2);

P1 = G;
C = G^2;
O = abs(rand(n,n));
for I = 1:n;
    for J = 1:n;
        if P1(I,J)~=0 || C(I,J)<0;
            O(I,J) = 0;
        else
            O(I,J) = 1;
        end
    end
end
P2 = O .* C;
P = P1 + 0.1 * P2;
DCol = full(sum(abs(P),2));
D = spdiags(DCol,0,n,n);
L = D-P;

nClass = 25;
%%%%input G, K, epsilon, itermax
%L = G.^10;
K = nClass;

epsilon = 0.0001;
itermax = 200;
beta = 0.8;
gama = 0.8;
t=1;

%X = abs(rand(n, K)); %%%%随机初始X
% X1 = X;
X = X3;
N = ones(K);

%f = trace(X* N *X');
% W1 = abs(rand(K));
% W1 = diag(diag(W1));
% W2 = abs(rand(K));
% W2 = W2-diag(diag(W2)-diag(0)) ;
W1 = eye(K);
W2 = ones(K);
W2 = W2-diag(diag(W2)-diag(0)) ;
verbose = true;
iter = 1;
delta = 2 * epsilon;
%NormalizeUV
K = size(W1,2);%把矩阵U的列数赋值给N。
norms = max(1e-15,sum(X,1))';
W1 = W1*spdiags(norms,0,K,K);
W2 = W2*spdiags(norms,0,K,K);
X = X*spdiags(norms,0,K,K);

while  iter <= itermax


    
    J_temp = 0.5 * norm(Gz - X*W1*X','fro').^2 + 0.5 * norm(Gf - X*W2*X','fro').^2 + beta * trace(X'*L*X) + gama * trace(X* N *X');

            %S1 = (inv(X'* X)) *( X' * Gz * X)* inv(X' * X);
            %S1 = (X' * X)\( X' * Gz * X)/(X' * X);
            C_TEMP = (X') * Gz * X;
            D_TEMP = (X') * X * W1 * (X') * X;
            W1= W1.*(C_TEMP./D_TEMP);
            A_TEMP = Gz*X*(W1')+Gf*X*W2';
            B_TEMP = X*W1*(X')*X*W1+X*W2*(X')*X*W2+beta*L*X+gama*X*N;
            X=X.*(A_TEMP./B_TEMP);
            %W1 = S1;
            %S2 = (inv(X'* X)) * (X' * Gf * X) * inv(X' * X); 
            %S2 = (X' * X)\( X' * Gf * X)/(X' * X);
            E_TEMP =(X') * Gf * X;
            F_TEMP = (X') * X * W2 * (X') * X;
            W2 = W2.*( E_TEMP./F_TEMP);
            A_TEMP = Gz*X*(W1')+Gf*X*W2';
            B_TEMP = X*W1*(X')*X*W1+X*W2*(X')*X*W2+beta*L*X+gama*X*N;
            X=X.*(A_TEMP./B_TEMP);
            %W2 = S2;  
            Jt = 0.5 * norm(Gz - X*W1*X','fro').^2 + 0.5 * norm(Gf - X*W2*X','fro').^2 + beta * trace(X'*L*X) + gama * trace(X* N *X'); 
            J(iter) = Jt;
            iter = iter + 1
            %J(iter) = Jt;
            if abs(Jt - J_temp) < epsilon;
                break
            end
end

[max_a,index]=max(X,[],2);
for i = 1:n
    X(i,:) = X(i,:)/sum(X(i,:));
    [~,idx_max] = max(X(i,:));
    Y(i,1) = idx_max;
end

A=com(1:1000,2);
B=index;
if length( A ) ~= length( B)
    error('length( A ) must == length( B)');
end
if iscolumn(A)
    A=A';
end
if iscolumn(B)
    B=B';
end
total = length(A);
A_ids = unique(A);
A_class = length(A_ids);
B_ids = unique(B);
B_class = length(B_ids);

% Mutual information
idAOccur = double (repmat( A, A_class, 1) == repmat( A_ids', 1, total ));
idBOccur = double (repmat( B, B_class, 1) == repmat( B_ids', 1, total ));
idABOccur = idAOccur * idBOccur';
Px = sum(idAOccur') / total;
Py = sum(idBOccur') / total;
Pxy = idABOccur / total;
MImatrix = Pxy .* log2(Pxy ./(Px' * Py)+eps);
MI = sum(MImatrix(:));
% Entropies
Hx = -sum(Px .* log2(Px + eps),2);
Hy = -sum(Py .* log2(Py + eps),2);
%Normalized Mutual informationx
%MIhat = 2 * MI / (Hx+Hy)
MIhat = MI / sqrt(Hx*Hy) %another version of NMIend









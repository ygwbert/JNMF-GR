function [G,Adjz,Adjf]=EdgeToAdj(M)

%其中r=size(A,1)该语句返回的时矩阵A的行数， c=size(A,2) 该语句返回的时矩阵A的列数。
%T=sparse(M(:,1),M(:,2),M(:,3));
%T=full(T);
%G = T;
%设置为对称矩阵;
%G = G+G';
%G(G>1) = 1;
%G(G<=-1) = -1;
%n=size(G,1);
%isolated_set = find(sum(abs(G),2)==0);
%selected_set = setdiff(1:n, isolated_set);

%G = G(selected_set, selected_set); %remove isolated point
G=M;
Gz = (abs(G) + G)/2;
Gf = (abs(G) - G)/2;
%Mz(Mz~=0) = 10000;
%Mf(Mf~=0) = 10000;
%ones(N)是产生一个N*N的全1矩阵,矩阵x(:,k)表示矩阵x中第k列所有元素组成的矩阵
Adjz=Gz;
Adjf=Gf;

end
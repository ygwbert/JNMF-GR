function [G,Adjz,Adjf]=EdgeToAdj(M)

%����r=size(A,1)����䷵�ص�ʱ����A�������� c=size(A,2) ����䷵�ص�ʱ����A��������
%T=sparse(M(:,1),M(:,2),M(:,3));
%T=full(T);
%G = T;
%����Ϊ�Գƾ���;
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
%ones(N)�ǲ���һ��N*N��ȫ1����,����x(:,k)��ʾ����x�е�k������Ԫ����ɵľ���
Adjz=Gz;
Adjf=Gf;

end
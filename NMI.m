function [MIhat] = NMI(~,~)

groundtruth = load('community.dat');
result = importdata('partition_10.txt');
A=result(1:1000,2);
B = groundtruth(1:1000,2);


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

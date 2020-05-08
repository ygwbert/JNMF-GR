# JNMF-GR
to detect social networks
## 符号描述
|符号	|注释|	大小|
|----|-----|-----|
|n	|节点数	|—|
|k	|社区数|	—|
|X	|符号网络的邻接矩阵|	n×n|
|〖 X〗^p	|正边网络的邻接矩阵	|n×n|
|X^n|	负边网络的邻接矩阵|	n×n|
|P_1	|一阶关系矩阵|	|n×n|
|P_2	|二阶关系矩阵	|n×n|
|P	|关系矩阵	|n×n|
|Ο	|—	|n×n|
|H^p	|正边网络的关联矩阵|	k×k|
|H^n	|负边网络的关联矩阵	|k×k|
|W	|隶属度矩阵|	n×k|
|α,β,γ,θ|权重参数|	—|
|iter	|迭代次数|	—|

## 目标函数
![Image text](https://github.com/ygwbert/JNMF-GR/blob/master/image%20storage/%E7%9B%AE%E6%A0%87%E5%87%BD%E6%95%B0.png)

## 构造拉格朗日函数，求偏导
![Image text](https://github.com/ygwbert/JNMF-GR/blob/master/image%20storage/%E6%9E%84%E9%80%A0%E6%8B%89%E6%A0%BC%E6%9C%97%E6%97%A5%E5%87%BD%E6%95%B0.png)

## 迭代公式
![Image text](https://github.com/ygwbert/JNMF-GR/blob/master/image%20storage/%E8%BF%AD%E4%BB%A3%E5%85%AC%E5%BC%8F.png)

## 算法流程
![Image text](https://github.com/ygwbert/JNMF-GR/blob/master/image%20storage/%E7%AE%97%E6%B3%95%E4%BC%AA%E4%BB%A3%E7%A0%81.png)

# JNMF-GR 代码符号说明

network.dat 社区成员关系 
community.dat GroundTruth
（25社区 1000个点） 
benchmark -N 1000 -k 30 -maxk 60 -mu 0.1 -minc 20 -maxc 50
-N		number of nodes

-k		average degree

-maxk		maximum degree

-mu		mixing parameter

-t1		minus exponent for the degree sequence

-t2		minus exponent for the community size distribution

-minc		minimum for the community sizes

-maxc		maximum for the community sizes

-on		number of overlapping nodes

-om		number of memberships of the overlapping nodes

-C              average clustering coefficient

X1.mat 最佳社区内部成员矩阵X



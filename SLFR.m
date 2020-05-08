function [M,net] = SLFR()
com=load('.\community.dat');
net1=load('.\network.dat');
[m,n] = size(net1);
net=zeros(m,3);
net=net1(1:m,1:2);
A=zeros(1000,1000);  
for i=1:1:m

    if com((net(i,1)),2)~=com((net(i,2)),2)
        if unifrnd (1,10)<=3
            net(i,3)=-1;   
        else
            net(i,3)=1;
        end
    else
         net(i,3)=1;
    end 
    a=(net(i,1));
    b=(net(i,2));
    M(a,b)=net(i,3);
end


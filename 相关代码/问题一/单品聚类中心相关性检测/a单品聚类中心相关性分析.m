clear;clc
load 'a单品聚类中心.mat'  %加载通过kmeans聚类方法获得的八个聚类中心的数据
%% 计算各个单品聚类中心之间的皮尔逊相关系数
% 已使用spss做出散点图，发现部分数据存在线性关系，部分数据线性关系不明显
[R,P] = corrcoef(X)   % 获得皮尔逊相关系数矩阵R 检验值p值矩阵P
                         %使用spss为表格标出显著性水平
%% 皮尔逊相关系数假设检验
x = -4:0.1:4;
y = tpdf(x,6);  %求t分布的概率密度值 自由度为n-2 即为6
figure(1)   %作出第一个图像
plot(x,y,'-')
grid on  % 加网格线
hold on  % 保留原图
tinv(0.975,6)    %  求出当置信水平为95%时的临界值为2.4469 

plot([-2.4469,-2.4469],[0,tpdf(-2.4469,6)],'r-')  % 累积密度函数cdf的反函数  作出直观的假设检验的数据分布情况
plot([2.4469,2.4469],[0,tpdf(2.4469,6)],'r-')
%% 皮尔逊相关系数成立的条件——正态分布检验
% 方法一：看数据的峰度和偏度是否符合正态分布的偏度和峰度（若偏度接近0，峰度接近3，则可判断其为正态分布）
skewness(X1)  %求偏度
kurtosis(X1)  %求峰度

%方法二：针对大样本（n>30）,对每一列进行正态分布JB检验
n_c = size(X1,2);  % 数据列数
H = zeros(1,6);  %初始化 h值矩阵
P = zeros(1,6);  %初始化 p值矩阵
for i = 1:n_c
    [h,p] = jbtest(X1(:,i),0.05);  %置信水平为95%
    H(i)=h;
    P(i)=p;
end
disp(H)
disp(P)
%若h=1时，表示拒绝原假设，即该随机变量不服从正态分布

%方法三：针对小样本（3<=n<50),使用spss进行夏皮洛，威尔克检验

%方法四：Q-Q图
qqplot(X(:,1))   %若为正态分布，则Q-Q图上的点会近似地在一条直线附近（但此种方法要求数据量足够大）

%% 计算各个单品聚类中心之间的斯皮尔曼相关系数及p值

[R,P]=corr(X1, 'type' , 'Spearman')


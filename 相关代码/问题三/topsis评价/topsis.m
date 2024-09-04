%%  第一步：判断是否需要正向化
[n,m] = size(X); %% 算出X矩阵的行和列数
disp(['共有' num2str(n) '个评价对象, ' num2str(m) '个评价指标'])   %% 输出评价对象和评价指标数
Judge = input(['这' num2str(m) '个指标是否需要经过正向化处理，需要请输入1 ，不需要输入0：  ']);  %% 判断正向化处理

if Judge == 1
    Position = input('请输入需要正向化处理的指标所在的列，例如第2、3、6三列需要处理，那么你需要输入[2,3,6]： '); %[2,3,5]
    disp('请输入需要处理的这些列的指标类型（1：极小型， 2：中间型， 3：区间型） ')  % 判断指标类型
    Type = input('例如：第2列是极小型，第3列是区间型，第6列是中间型，就输入[1,3,2]：  '); %[2,1,3]
   
    for i = 1 : size(Position,2)   %% 循环开始
        X(:,Position(i)) = Positivization(X(:,Position(i)),Type(i),Position(i));
    end
    disp('正向化后的矩阵 X =  ')  %输出正向化矩阵
    disp(X)  %输出X
end
%% 第二步：对正向化后的矩阵进行标准化
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);  %将矩阵进行点除
disp('标准化矩阵 Z = ')
disp(Z)
%% 第三步：计算与最大值的距离和最小值的距离，并算出得分
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ],2) .^ 0.5;     %%计算正理想值
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ],2) .^ 0.5;     %%计算负理想值
S = D_N ./ (D_P+D_N);   %%计算出贴近度S
disp('最后的得分为：')
stand_S = S / sum(S)   %%计算标准化得分
[sorted_S,index] = sort(stand_S ,'descend')


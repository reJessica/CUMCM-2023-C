function [posit_x] = Inter2Max(x,a,b)
    r_x = size(x,1);   %%计算行列数
    M = max([a-min(x),max(x)-b]);   %%指标正向化
    posit_x = zeros(r_x,1);     
    
    for i = 1: r_x   %%开始循环
        if x(i) < a   %%判断条件
           posit_x(i) = 1-(a-x(i))/M;
        elseif x(i) > b  %%判断条件
           posit_x(i) = 1-(x(i)-b)/M;   
        else
           posit_x(i) = 1;  %%判断条件
        end
    end
end

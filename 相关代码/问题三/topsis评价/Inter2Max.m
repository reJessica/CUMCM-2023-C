function [posit_x] = Inter2Max(x,a,b)
    r_x = size(x,1);   %%����������
    M = max([a-min(x),max(x)-b]);   %%ָ������
    posit_x = zeros(r_x,1);     
    
    for i = 1: r_x   %%��ʼѭ��
        if x(i) < a   %%�ж�����
           posit_x(i) = 1-(a-x(i))/M;
        elseif x(i) > b  %%�ж�����
           posit_x(i) = 1-(x(i)-b)/M;   
        else
           posit_x(i) = 1;  %%�ж�����
        end
    end
end

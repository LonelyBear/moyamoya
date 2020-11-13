function [Hu] = adaptIterativeThreshold(volume_input)
%ADAPTITERATIVETHRESHOLD 此处显示有关此函数的摘要
%   此处显示详细说明
%   通过计算自适应阈值迭代得到相似度函数的Hu值
process_volume = round(volume_input);

[L,M,N] = size(process_volume);
unI = sort(unique(process_volume));
[histo,pixval] = hist(process_volume(:),unI);

%%%%%%%计算平均值
average_gray = 0;
sum_gray = 0;
for i = 1:length(unI)
    sum_gray = sum_gray + histo(i)*pixval(i);
end
average_gray = sum_gray/(L*M*N);

Thre_volume = 0;
Thre_volume_1 = round(average_gray);
while(Thre_volume ~= Thre_volume_1)
    
    Thre_volume = Thre_volume_1;
    count = find(pixval == Thre_volume);
    aws1_sum_1 = 0;
    aws1_sum_2 = 0;
    aws1 = 0;
    aws2_sum_1 = 0;
    aws2_sum_2 = 0;
    aws2 = 0;
    for i = 1:count
        aws1_sum_1 =  histo(i)*pixval(i) + aws1_sum_1;
        aws1_sum_2 = histo(i) + aws1_sum_2;
    end
    aws1 = aws1_sum_1/aws1_sum_2;
    for i = count+1:length(pixval)
        aws2_sum_1 =  histo(i)*pixval(i) + aws2_sum_1;
        aws2_sum_2 = histo(i) + aws2_sum_2;        
    end
    aws2 = aws2_sum_1/aws2_sum_2;
    Thre_volume_1 = round(0.5*(aws1+aws2));
    
end

Hu = Thre_volume_1;

end


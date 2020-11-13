function [minh,reg_threshold] = calculateH(calc_pix,gradient_pix,maxgray)

% @version  1.0
% @author  yang
% @param
%   calc_pix    输入图像的像素矩阵     m*1矩阵
%   gradient_pix    输入图像的梯度矩阵  与calc_pix  对应
%   maxgray     原图的灰度最大值
% @return
% minh   目标函数的最小值
% reg_threshold   阈值

h_mean = mean(calc_pix);
h_std = std(calc_pix);
reg_threshold = h_std;
graysta = zeros(maxgray+1,1);
h_count = numel(calc_pix);
h_graymul = 0;
for i = 1:h_count
    a = calc_pix(i);
    graysta(a) = graysta(a)+1;
end
for i = 1:maxgray
    h_graymul = graysta(i) * i + h_graymul;
end
Upi = h_graymul / h_count;
h_delte_temp = 0;
for i = 1:maxgray
    h_delte_temp = (i-Upi)*(i-Upi)*graysta(i) + h_delte_temp;
end
Dpi = h_delte_temp/h_count;
Gpi = zeros(maxgray+1,1);
for i = 1:maxgray
    if graysta(i) == 0
        continue;
    else
        for j = 1:h_count
            if calc_pix(j) == i 
                Gpi(i) = Gpi(i) + gradient_pix(j);
            end
        end
        Gpi(i) = graysta(i) / Gpi(i);
    end       
end
beta = 1 / (1 + (sqrt(Dpi)/(2*pi*pi)));
alpha = beta * (sqrt(Dpi)/(2*pi*pi));
h = abs(alpha * Gpi + beta * sqrt(Dpi)); 
minh = min(h);
end
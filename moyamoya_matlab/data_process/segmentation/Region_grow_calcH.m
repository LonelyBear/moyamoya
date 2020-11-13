function grow_h = Region_grow_calcH(I,I_gradient,J,maxgray,reg_size,connect,volume_size)
%REGION_GROW_CALCH 此处显示有关此函数的摘要
%   此处显示详细说明
% @version  2.0
% @author  yang
% @param
%   calc_pix    输入图像的像素矩阵     m*1矩阵
%   gradient_pix    输入图像的梯度矩阵  与calc_pix  对应
%   maxgray     原图的灰度最大值
% @return
% minh   目标函数的值
% reg_threshold   阈值
% 针对3D体素的模型函数计算，上一版本的程序有两个问题：
% 1.梯度只是使用了一个方向
% 2 上一版本的梯度函数是针对整个ROI 而不是边界，这一次计算边界的梯度均值

% version 2.0
% 计算边界参数
reg_temp_pix = zeros(reg_size,4); %%用于记录当前区域的像素矩阵
reg_temp_gra = zeros(reg_size,4);% 梯度
reg_temp_count = 0;
contour_count = 0; % contour_count 边界参数点
contour_gra_point = zeros(reg_size,1); % contour_point 边界点梯度值的集合

for i = 1:volume_size(1)
    for j = 1:volume_size(2)
        for k = 1:volume_size(3)
            if(J(i,j,k) == 2)
                reg_temp_count = reg_temp_count + 1;
                reg_temp_pix(reg_temp_count,:) = [i,j,k,I(i,j,k)];
                reg_temp_gra(reg_temp_count,:) = [i,j,k,I_gradient(i,j,k)]; 
                
                if (i == 1 || j == 1 || k == 1 || i == volume_size(1) || j == volume_size(2) || k == volume_size(3) )
                    contour_count = contour_count + 1;
                    contour_gra_point(contour_count) = I_gradient(i,j,k);
                    continue;
                end
                b_connected = 1;
                for connect_num = 1:26
                    x_connect = i + connect(connect_num,1); 
                    y_connect = j + connect(connect_num,2); 
                    z_connect = k + connect(connect_num,3); 
                    if (J(x_connect,y_connect,z_connect) ~= 2)
                        b_connected = 0;
                    end                 
                end
                if (b_connected == 0)
                    contour_count = contour_count + 1;
                    contour_gra_point(contour_count) = I_gradient(i,j,k);
                end
            end
        end
    end
end

h_mean = mean(reg_temp_pix);
h_mean = h_mean(1,4);
h_std = std(reg_temp_pix);
h_std = h_std(1,4);
graysta = zeros(maxgray+1,1);
h_count = reg_size;
h_graymul = 0;
for i = 1:h_count
    a = reg_temp_pix(i,4);
    if(a == 0)
        graysta(maxgray+1) = graysta(maxgray+1)+1;
        continue;
    end
    graysta(a) = graysta(a)+1;
end
for i = 1:maxgray
    h_graymul = graysta(i) * i + h_graymul;
end
Upi = h_graymul / h_count;  % 区域内的灰度平均值 Upi
h_delte_temp = 0;
for i = 1:maxgray
    h_delte_temp = (i-Upi)*(i-Upi)*graysta(i) + h_delte_temp;
end
% 区域内灰度的类内方差 Dpi 
Dpi = h_delte_temp/h_count;

% 边界的梯度平均值 Gpi
Gpi = 0;
for i = 1:contour_count
    Gpi = Gpi + contour_gra_point(contour_count);
end
Gpi = Gpi/contour_count;

% version 1.0
% Gpi = zeros(maxgray+1,1);
% for i = 1:maxgray
%     if graysta(i) == 0
%         continue;
%     else
%         for j = 1:h_count
%             if calc_pix(j) == i 
%                 Gpi(i) = Gpi(i) + gradient_pix(j);
%             end
%         end
%         Gpi(i) = graysta(i) / Gpi(i);
%     end       
% end


beta = 1 / (1 + (sqrt(Dpi)/(2*pi*pi)));
alpha = beta * (sqrt(Dpi)/(2*pi*pi));
grow_h = abs(alpha * Gpi + beta * sqrt(Dpi)); 
disp(['模型函数值: ' num2str(grow_h)]);
end


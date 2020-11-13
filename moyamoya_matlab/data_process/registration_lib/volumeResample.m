function output_volume = volumeResample(input_volume,output_size,interpolation_type)
%VOLUMERESAMPLE 此处显示有关此函数的摘要
%   此处显示详细说明
%   interpolation_type  
%   0   Nearest Neighbor Interpolation
%   1   Linear Interpolation
%   2   B-Spline Interpolation
disp('volume resample processing');
[L,M,N] = size(input_volume);  %  
L1 = output_size(1);
M1 = output_size(2);
N1 = output_size(3);
volume_pro = input_volume;
volume_processed = zeros(L1,M1,N1);

switch interpolation_type
    case 0
        warning('Nearest Neighbor Interpolation  no  function');
        return;
    case 1
        L_mul = L1/L;
        M_mul = M1/M;
        N_mul = N1/N;
        rot=[L_mul 0 0;0 M_mul 0;0 0 N_mul];%变换矩阵
        disp('.....')
        for i = 1:L1
            for j = 1:M1
                for k = 1:N1
                    pix = [i j k]/rot; 
                    float_Y = pix(1)-floor(pix(1)); 
                    float_X = pix(2)-floor(pix(2));
                    float_Z = pix(3)-floor(pix(3));
                    %边界处理                   
                    if pix(1) < 1
                        pix(1) = 1;
                    end        
                    if pix(1) > L
                        pix(1) = L;
                    end       
                    if pix(2) < 1
                        pix(2) = 1;
                    end        
                    if pix(2) > M
                        pix(2) = M;
                    end
                    if pix(3) < 1
                        pix(3) = 1;
                    end        
                    if pix(3) > N
                        pix(3) = N;
                    end 
                    %定义三维八点坐标
                    pix_up_left_front = [floor(pix(1)),floor(pix(2)),floor(pix(3))];
                    pix_up_right_front = [floor(pix(1)),ceil(pix(2)),floor(pix(3))];
                    pix_down_left_front = [ceil(pix(1)),floor(pix(2)),floor(pix(3))];
                    pix_down_right_front = [ceil(pix(1)),ceil(pix(2)),floor(pix(3))];
                    pix_up_left_behind = [floor(pix(1)),floor(pix(2)),ceil(pix(3))];
                    pix_up_right_behind = [floor(pix(1)),ceil(pix(2)),ceil(pix(3))];
                    pix_down_left_behind = [ceil(pix(1)),floor(pix(2)),ceil(pix(3))];
                    pix_down_right_behind = [ceil(pix(1)),ceil(pix(2)),ceil(pix(3))];
                    %计算邻近八个点的权重
                    value_up_left_front = (1-float_X)*(1-float_Y)*(1-float_Z);
                    value_up_right_front = float_X*(1-float_Y)*(1-float_Z);
                    value_down_left_front = (1-float_X)*float_Y*(1-float_Z);
                    value_down_right_front = float_X*float_Y*(1-float_Z);
                    value_up_left_behind = (1-float_X)*(1-float_Y)*float_Z;
                    value_up_right_behind = float_X*(1-float_Y)*float_Z;
                    value_down_left_behind = (1-float_X)*float_Y*float_Z;
                    value_down_right_behind = float_X*float_Y*float_Z; 
                    %线性插值
                    volume_processed(i,j,k) =   value_up_left_front * volume_pro(pix_up_left_front(1),pix_up_left_front(2),pix_up_left_front(3))+ ...
                                                value_up_right_front * volume_pro(pix_up_right_front(1),pix_up_right_front(2),pix_up_right_front(3))+ ...
                                                value_down_left_front * volume_pro(pix_down_left_front(1),pix_down_left_front(2),pix_down_left_front(3))+ ...
                                                value_down_right_front * volume_pro(pix_down_right_front(1),pix_down_right_front(2),pix_down_right_front(3))+...
                                                value_up_left_behind * volume_pro(pix_up_left_behind(1),pix_up_left_behind(2),pix_up_left_behind(3))+ ...
                                                value_up_right_behind * volume_pro(pix_up_right_behind(1),pix_up_right_behind(2),pix_up_right_behind(3))+ ...
                                                value_down_left_behind * volume_pro(pix_down_left_behind(1),pix_down_left_behind(2),pix_down_left_behind(3))+ ...
                                                value_down_right_behind * volume_pro(pix_down_right_behind(1),pix_down_right_behind(2),pix_down_right_behind(3));
                end
            end
        end


    case 2
        warning('B-Spline Interpolation  no  function');
        return;
end
output_volume = volume_processed;
end



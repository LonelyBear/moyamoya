function grow_h = Region_grow_calcH(I,I_gradient,J,maxgray,reg_size,connect,volume_size)
%REGION_GROW_CALCH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% @version  2.0
% @author  yang
% @param
%   calc_pix    ����ͼ������ؾ���     m*1����
%   gradient_pix    ����ͼ����ݶȾ���  ��calc_pix  ��Ӧ
%   maxgray     ԭͼ�ĻҶ����ֵ
% @return
% minh   Ŀ�꺯����ֵ
% reg_threshold   ��ֵ
% ���3D���ص�ģ�ͺ������㣬��һ�汾�ĳ������������⣺
% 1.�ݶ�ֻ��ʹ����һ������
% 2 ��һ�汾���ݶȺ������������ROI �����Ǳ߽磬��һ�μ���߽���ݶȾ�ֵ

% version 2.0
% ����߽����
reg_temp_pix = zeros(reg_size,4); %%���ڼ�¼��ǰ��������ؾ���
reg_temp_gra = zeros(reg_size,4);% �ݶ�
reg_temp_count = 0;
contour_count = 0; % contour_count �߽������
contour_gra_point = zeros(reg_size,1); % contour_point �߽���ݶ�ֵ�ļ���

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
Upi = h_graymul / h_count;  % �����ڵĻҶ�ƽ��ֵ Upi
h_delte_temp = 0;
for i = 1:maxgray
    h_delte_temp = (i-Upi)*(i-Upi)*graysta(i) + h_delte_temp;
end
% �����ڻҶȵ����ڷ��� Dpi 
Dpi = h_delte_temp/h_count;

% �߽���ݶ�ƽ��ֵ Gpi
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
disp(['ģ�ͺ���ֵ: ' num2str(grow_h)]);
end


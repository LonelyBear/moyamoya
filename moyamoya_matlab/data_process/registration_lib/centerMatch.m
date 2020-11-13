function [output_volume] = centerMatch(input_volume)
%CENTERMATCH 此处显示有关此函数的摘要
% 此函数实现中心点匹配的功能  对两个序列的图像进行初步匹配
%   此处显示详细说明
output_size = [672,672,210];
volume_resample = volumeResample(input_volume,output_size,1);
[L,M,N] = size(volume_resample);
L1 = 768;
M1 = 594;
N1 = 210;
position_volume = zeros(L1,M1,N1);%最终变换的矩阵
for pos_slice = 1:N
    for pos_i = 1:L
        for pos_j = 1:M
            if volume_resample(pos_i,pos_j,pos_slice) ~= 0
                trans_i = pos_i - L/2 + L1/2;
                trans_j = pos_j - M/2 + M1/2;
                trans_slice = pos_slice;
                position_volume(trans_i,trans_j,trans_slice) = 200;
            end
        end
    end
end
%  for pos_i = 1:M
%      for pos_k = 1:N
%          if resultImage(pos_i,pos_k) ~= 0
%              trans_k = pos_k-N/2+N1/2;
%              trans_i = pos_i-M/2+M1/2;            
%              position(trans_i,trans_k) = max(max(position));
%          end
%      end
%  end
output_volume = position_volume;
end


function Volume_out = erode3D(volume_input,se_option)

%%%%%volume_input为二值三维图像%%%%%
%%%%%设定strel%%%%% 1为菱形  其他数字为one（3）
    strel_diamond = [   -1  0  0;  
                                1  0  0;
                                0  1  0;  
                                0 -1  0; 
                                0  0 -1;
                                0  0  1;
                                0  0  0];
    strel_one = [   -1 -1 -1; -1 -1 0; -1 -1 1;
                           -1  0 -1; -1  0 0; -1  0 1;
                           -1  1 -1; -1  1 0; -1  1 1;
                            0 -1 -1;  0 -1 0;  0 -1 1;
                            0  0 -1;  0  0 0;  0  0 1;
                            0  1 -1;  0  1 0;  0  1 1;
                            1 -1 -1;  1 -1 0;  1 -1 1;             
                            1  0 -1;  1  0 0;  1  0 1;
                            1  1 -1;  1  1 0;  1  1 1;];  
    if (se_option == 1)    
        erode_strel = strel_diamond;
    else
        erode_strel = strel_one;
    end                    
    erode_strel_size = size(erode_strel);   
    
                
    [L,M,N] = size(volume_input);
    volume_process = volume_input;
    volume_processed = zeros(L,M,N);
    for i = 2:L-1
        for j = 2:M-1
            for k = 2:N-1
                if(volume_process(i,j,k) == 1)
                    erode_value = 1;
                    for n = 1:7
                        if(volume_process(i+erode_strel(n,1),j+erode_strel(n,2),k+erode_strel(n,3)) == 0)
                            erode_value = 0;
                        end
                    end 
                    if(erode_value == 0)
                        volume_processed(i,j,k) = 0;
                    else
                        volume_processed(i,j,k) = 1;
                    end
                end
            end
        end
    end
    
    Volume_out = volume_processed;
end
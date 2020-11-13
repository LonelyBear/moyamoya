function Volume_out = dilate3D(volume_input,se_option)
    
%%%%%volume_input为二值三维图像%%%%%
%%%%%设定strel%%%%%  1为菱形  其他数字为one（3）
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
        dilate_strel = strel_diamond;
    else
        dilate_strel = strel_one;
    end                    
    dilate_strel_size = size(dilate_strel);                
                    
                    
       
    [L,M,N] = size(volume_input);
    volume_process = volume_input;
    volume_processed = zeros(L,M,N);

    for i = 2:L-1
        for j = 2:M-1
            for k = 2:N-1
                if(volume_process(i,j,k) == 1)
                    for n = 1:dilate_strel_size(1)
                        volume_processed(i+dilate_strel(n,1),j+dilate_strel(n,2),k+dilate_strel(n,3)) = 1;
                    end                        
                end
            end
        end
    end
    
    Volume_out = volume_processed;
end
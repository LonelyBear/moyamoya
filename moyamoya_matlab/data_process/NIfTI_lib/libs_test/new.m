clc;clear;
nii = load_untouch_nii('D:\Space\moyamoya-1\moyamoya_gui\Moyamoya Processing\experiment data\pu_mra_tof.nii')
data = nii.img;
% for i = 1:210
%     imshow(data(:,:,i),[]);
% end
test = make_nii(data,[0.286326766014099,0.286326795816422,0.500000000000000],[-26368,-27272,-12356],512);
%test.hdr.hist.qform_code = 1;
save_untouch_nii(test,'D:\1.nii');
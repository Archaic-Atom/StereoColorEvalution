disp('======= KITTI 2015 Benchmark Demo =======');
clear all; 
close all; 
dbstop error;
addpath(genpath('./libs/'));

% error threshold
tau = [3 0.05];
% id
kitti_id  = '000000';
% path
disp_path        = ['../example/disp/',kitti_id,'_10.png'];
gt_path          = ['../example/gt/',kitti_id,'_10.png'];
color_disp_save_path  = ['../example/result/',kitti_id,'_10_disp.png'];
color_gt_save_path = ['../example/result/',kitti_id,'_10_gt.png'];
color_error_save_path = ['../example/result/',kitti_id,'_10_err.png'];

disp('Load disparity map ... ');
disp_img = double(imread(disp_path));
gt_img   = disp_read(gt_path);

disp('Compute disparity map ... ');
disp_err     = disp_error(gt_img, disp_img, tau);
disp_err_img = disp_error_image(gt_img, disp_img, tau);
color_map    = disp_to_color([disp_img; gt_img], max(gt_img(:)));

disp('Show disparity map ... ');
figure(1)
result_image = [color_map;disp_err_img];
imshow(result_image)
title(sprintf('Disparity Error: %.2f %%',disp_err*100));

disp('Save color disparity map ... ');
disp_shape = size(disp_img);
off_set = 1;
height_dim = 1;
imwrite(disp_err_img,color_error_save_path);
imwrite(color_map(off_set:disp_shape(height_dim),:,:), color_disp_save_path);
imwrite(color_map(disp_shape(height_dim)+off_set:disp_shape(height_dim)*2,:,:), color_gt_save_path);

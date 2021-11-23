function img2video(dn, picformat,aviname)
% CreatVideoFromPic(dn, picformat,aviname)
% 将某个文件夹下某种格式的所有图片合成为视频文件
% dn : image folder
% picformat : image type
% aviname   : viedo name
% example : CreatVideoFromPic( './', 'png','presentation.avi');

    if ~exist(dn, 'dir')
        error('dir not exist!!!!');
    end
    picname=fullfile( dn, strcat('*.',picformat));
    picname=dir(picname);

    aviobj = VideoWriter(aviname);
    aviobj.FrameRate=10;

    open(aviobj);

    for i=1:length(picname)
        picdata=imread( fullfile(dn, (picname(i,1).name)));
        if ~isempty( aviobj.Height)
            if size(picdata,1) ~= aviobj.Height || size(picdata,2) ~= aviobj.Width
                close(aviobj);
                delete( aviname )
                error('所有图片的尺寸要相同！！');
            end
        end
        writeVideo(aviobj,picdata);
        
    end
    close(aviobj);
end

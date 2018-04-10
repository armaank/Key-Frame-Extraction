%% Key Frame Extraction
% Written by Armaan Kohli
% the following program preforms key frame extraction by taking the
% histogram difference between two frames, then testing how much the two
% frames differ, and then extracting frames 
clear;

V = 'traffic.mj2';  %Video Name  
vidobj = VideoReader(V);   

% loop through frames to determine mean and stddev
N=vidobj.NumberofFrames;            
for i=1:N
    k=read( vidobj,i);          
        if(i~=vidobj.NumberOfFrames);
            j=read(vidobj,i+1);
            fr1=rgb2gray(k);  % conversion to grayscale 
            fr2=rgb2gray(j);
            Hfr1=imhist(fr1);  % calculates histogram of image
            Hfr2=imhist(fr2);
            diff=imabsdiff(Hfr1,Hfr2); % Difference between the two images
            in=sum(diff);
            X(i)=in;
        end
end

% extracts frames from threshold cacluated from the std. dev and mean
mean=mean2(X);
std=std2(X);
threshold=mean+std*1.5;
for i=1:N
    p=read(vidobj,i);
        if(i~=vidobj.NumberOfFrames)
            j=read(vidobj,i+1);
            fr1=rgb2gray(p);  
            fr2=rgb2gray(j);
            Hfr1=imhist(fr1);  
            Hfr2=imhist(fr2);
            diff=imabsdiff(Hfr1,Hfr2);
            in=sum(diff);
            if(in>threshold)  
                filename = fullfile('~/Keyframes', sprintf('frame_%05d.JPG', i));  
                imwrite(j, filename);
            end 
        end
end 
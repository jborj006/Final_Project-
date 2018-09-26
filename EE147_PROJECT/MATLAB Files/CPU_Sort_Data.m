%Before starting the program be sure to manually clear the workspace
%Start the stop watch to measure performance
tic

%% change directory
cd('/home/eemaj/jborja/EE147_PROJECT')

%% load data
load('data_new.mat')

h = figure;
%Create Object to create video
obj = VideoWriter('CPU_3D_damage.avi');
open(obj);

for i = 300:500
    color = damage(:,i);   %damage is the percentenge of the number of bonds broken 
 for j = 1:atoms
        if color(j,1) < .45      %45 percent is standard accepted value of broken glass  
            color(j) = .000001;  %close to zero 
        end
 end
    scatter3(coordinate(:,1,i),coordinate(:,2,i),coordinate(:,3,i),color)
    daspect([1 1 1])
    view([70 50])
    pos_h = [0 0 1362 687]; % Adjusted to indidual user's PC
    set(h,'Position',pos_h)
   currentFrame = getframe(h);
   
    writeVideo(obj,currentFrame);
    
    %Display percent complete 
    num = (i-300)/200 * 100; 
    fprintf('%.2f%% Loaded\n',num)   
   
end

close(obj);

%End the stopwatch  
toc
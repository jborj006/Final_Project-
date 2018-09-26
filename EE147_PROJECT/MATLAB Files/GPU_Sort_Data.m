%Before starting the program be sure to manually clear the workspace
%Start the stop watch to measure performance
tic

%% change directory
cd('/home/eemaj/jborja/EE147_PROJECT')

%% load data
load('data_new.mat')

%Create the KERNEL
K_Kern = parallel.gpu.CUDAKernel('GlassKernel.ptx','GlassKernel.cu'); 

%Specify the number of threads 
K_Kern.ThreadBlockSize = [K_Kern.MaxThreadsPerBlock, 1, 1];

%Specify the size fo the grid
GridsTotal = ceil(atoms/K_Kern.MaxThreadsPerBlock)+1; %number of grids which is 102 
K_Kern.GridSize = [GridsTotal, 1];

h = figure;
obj = VideoWriter('GPU_3D_damage.avi');
open(obj);

for i = 300:500
    
    %returns the numbers of each column of damage
    color = damage(:,i);  
    
    %Call GPU ArrAY
    G1 = gpuArray(single(color));
    G2 = feval(K_Kern,G1,atoms);
    color = double(gather(G2));

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
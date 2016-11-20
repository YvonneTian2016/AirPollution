function [Fea_TRA, Train_Tar, Fea_Test, Test_Bck_ID] = features(Data, Pre_Off)
 
Back_Time = 8;
Data=load('../../Data.csv');
Fea_TRA = zeros(40000, 3 + 56*Back_Time);
Fea_Test = zeros(500, 3 + 56*Back_Time);
 
Train_Tar = zeros(40000, 21);
 
Test_Bck_ID = [];
 
Fea_CI = 0;
Test_CI = 0;
for i=1:size(Data,1)-Back_Time-Pre_Off+1
    if Data(i,2)==Data(i+Back_Time+Pre_Off-1,2)
        Fea_CI = Fea_CI + 1;
        Fea_TRA(Fea_CI,1:3) = Data(i, 4:6);
        Cur_Fea = Data(i:i+Back_Time-1,7:end);
        Fea_TRA(Fea_CI,4:end) = Cur_Fea(:)';
        
        Train_Tar(Fea_CI, :) = Data(i+Back_Time+Pre_Off-1, 7:27);
    end
    
    if Data(i,2) ~= Data(i+1,2)
        Test_CI = Test_CI + 1;
        i_back = i - Back_Time + 1;
        Fea_Test(Test_CI,1:3) = Data(i_back, 4:6);
 
        Cur_Fea = Data(i_back:i_back+Back_Time-1,7:end);
        Fea_Test(Test_CI,4:end) = Cur_Fea(:)';
        Test_Bck_ID(end+1) = Data(i_back,2);
    end
end
 
Test_CI = Test_CI + 1;
i_back = size(Data,1) - Back_Time + 1;
Fea_Test(Test_CI,1:3) = Data(i_back, 4:6);
 
Cur_Fea = Data(i_back:i_back+Back_Time-1,7:end);
Fea_Test(Test_CI,4:end) = Cur_Fea(:)'; 
Test_Bck_ID(end+1) = Data(i_back,2);
 
Train_Tar = Train_Tar(1:Fea_CI,:);
Fea_TRA = Fea_TRA(1:Fea_CI,:);
Fea_Test = Fea_Test(1:Test_CI, :);
 
dlmwrite('features.csv',Fea_TRA);

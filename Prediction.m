Pre_Ofs = [1 2 3 4 5 10 17 24 48 72];
 
Data = load('../../Data.csv');
 
Test_Pre = zeros(330,21);
 
options = statset();
 
for p=1:10
    P_Off = Pre_Ofs(p);
    [Fea_TRA, Train_Tar, Fea_Test, Test_Bck_ID] = Features(Data, P_Off);
    tic
    for i=1:size(Train_Tar,2)
        disp([int2str(p),'   ',int2str(i)]);
        Loc = find(Train_Tar(:,i)>=0);
        TMachine = TreeBagger(12,Fea_TRA(Loc,:),Train_Tar(Loc,i),'method','regression','minleaf',200,'options',options);
        Pred = Predict(TMachine,Fea_Test);
        for j=1:length(Test_Bck_ID)
            Test_Pre(Test_Bck_ID(j)*10-10+p,i) = Pred(j);
        end
    end
    toc
end

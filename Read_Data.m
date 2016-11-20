clc;
fprintf('Reading data ......\n');
file = fopen('1.csv');
fgetl(file);
 
Temp_Data = zeros(8712,62);
Day_o_Week = {'Saturday','Sunday','Monday','Tuesday','Wednesday','Thursday','Friday'};
Row_I = 0;
 
while ~feof(file)
    Row_I = Row_I + 1;
    Line = fgetl(file);
    C = strread(Line,'%s','delimiter',','); 
    for i=1:62
        if i==5
            Temp_Data(Row_I,i) = find(strcmp(Day_o_Week,C{i}));
        else
           if strcmp(C{i},'null')||strcmp(C{i},'null ')    %%Clean Data
                Temp_Data(Row_I,i) = -100000;
                disp([int2str(i),'   ',int2str(Row_I)]);
           else
                Temp_Data(Row_I,i) = str2num(C{i});
            end
        end
    end
end
 
Data=zeros(6336,62);
Data_Unknown=zeros(2376,62);
for i=0:32
    Data(192*i+1:192*i+192,:)=Temp_Data(264*i+1:264*i+192,:);
    Data_Unknown(72*i+1:72*i+72,:)=Temp_Data(264*i+193:264*i+264,:);
end

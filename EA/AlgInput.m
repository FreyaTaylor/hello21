function [tasks,arcs] = AlgInput(file_name)
% Usage: [tasks,arcs] = AlgInput(file_name)
%
% Input:
% file_name           -name of the .tgff file that store task graph 
%
% Output: 
% tasks               -tasks of task graph
% arcs                -arcs of task graph%        

rand('state',sum(300));%让每次生成的随机数相同（种子相同）

task_id={};%用于生成task的cell数组，记录task_id
arc_id={};%用于生成arc的cell数组，记录arc_id、arc_from、arc_to
arc_from={};
arc_to={};

%数据读取
fid=fopen(file_name,'r');
count=1;%用于打印文件输入的行数,以检查
tline = fgetl(fid);
while ischar(tline)
    if ~isempty(strfind(tline,'TASK_GRAPH'))%找到第一行数据
        tline = fgetl(fid);
        count=count+1;
        continue;
    end
    
    if ~isempty(strfind(tline,'TASK'))%找到第一行TASK数据
        str=tline;%TASK t0_0	TYPE 9 
        str=strtrim(str);
        str= regexp(str, '\s+', 'split');%cell数组
        size(str);%1×4 cell 数组
        task_id=[task_id;str{2}]; %cell 数组，列拼接
    end

    if ~isempty(strfind(tline,'}'))%TASK_GRAPH结束
        break;
    end
    
    tline = fgetl(fid);
    count=count+1;
end
fclose(fid);



%第一版，table形式的[tasks,arcs]生成
task=table(task_id);%
arc=table(arc_id,arc_from,arc_to);

%将tasks,arcs中的id的字符串转为数字
task=table2array(task);%因为有str，转成了cell 数组，遍历转换后还是cell数组
arc=table2array(arc);
for i=1:size(task,1)%将id的字符串转为数字
    for j=1:size(task,2)
        str=task{i,j};
        str=str(4:1:end);
        id=str2num(str)+1;%core id是从0开始的
        task{i,j}=id;
    end
end
for i=1:size(arc,1)%将id的字符串转为数字
    for j=1:size(arc,2)
        str=arc{i,j};
        str=str(4:1:end);
        id=str2num(str)+1;%core id是从0开始的
        arc{i,j}=id;
    end
end
%转换成数字后cell2mat，是矩阵
task=cell2mat(task);
arc=cell2mat(arc);

%转换成struct类型，这一步以后是tasks和arcs
for i=1:size(task,1)
    tasks(i).id=task(i);
end

for i=1:size(arc,1)
    arcs(i).id=arc(i,1);
    arcs(i).from=arc(i,2);
    arcs(i).to=arc(i,3); 
end
   


        
        
     

end















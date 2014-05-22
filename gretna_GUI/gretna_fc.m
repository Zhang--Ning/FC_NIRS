function gretna_fc(DataList ,  LabMask , OutputName)
    P=spm_vol(DataList);
    TimePoint=size(P , 1);
    PMask=spm_vol(LabMask);
    Mask=spm_read_vols(PMask);
    Mask=reshape(Mask , [] , 1);
    Node=max(Mask , [] ,  1);
 
    Volume=spm_read_vols(cell2mat(P));
    Volume=reshape(Volume , [] , TimePoint);   
    
    
    TimeCourse=zeros(TimePoint , Node);      
    for i=1:Node
        Pos= Mask==i;
        OneNodeTC=Volume(Pos , :);
        
        MeanTC=mean(OneNodeTC , 1);
        TimeCourse(:,i)=MeanTC;
    end
    r=corrcoef(TimeCourse);
    r(isnan(r))=0;
    [Path , File , Ext]=fileparts(OutputName);
    save([Path , filesep , 'TimeCourse_' , File , Ext] ,...
        'TimeCourse' , '-ASCII', '-DOUBLE','-TABS');
    save(OutputName , 'r' , '-ASCII', '-DOUBLE','-TABS');

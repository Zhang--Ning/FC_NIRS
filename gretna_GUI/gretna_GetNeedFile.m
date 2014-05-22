function ImageList=gretna_GetNeedFile(ParentDir , Prefix , SubjName)
    Subj=dir(ParentDir);
    ImageList=[];
    for i=1:size(Subj , 1)
        if ~strcmp(Subj(i).name , '.') && ~strcmp(Subj(i).name , '..') ...
            && ~strcmp(Subj(i).name , '.DS_Store')
            if Subj(i).isdir && strcmp(Subj(i).name , SubjName)
                SubjImage=dir([ParentDir , filesep , Subj(i).name,...
                    filesep , Prefix]);
                if ~isempty(SubjImage)
                    if strcmp(SubjImage(1).name , '.')
                        SubjImage(1)=[];
                        if strcmp(SubjImage(1).name , '..')
                            SubjImage(1)=[];
                            if strcmp(SubjImage(1).name , '.DS_Store')
                                SubjImage(1)=[];
                            end
                        end
                    end
                end
                
                if isempty(SubjImage)
                    errordlg(sprintf('There is no %s file in %s' , ...
                        Prefix , SubjName));
                    return;
                end
                
                if size(SubjImage,2)~=1
                    errordlg(sprintf('Please ensure that there is just one %s file in %s' , ...
                        Prefix , SubjName));
                    return;
                end
                
                [Path , Name ,Ext]=...
                	fileparts([ParentDir , filesep ,...
                    Subj(i).name , filesep , SubjImage(1).name]);
                    if strcmp(Ext , '.img') || strcmp(Ext , '.txt')||...
                    	strcmp(Ext , '.nii') || strcmp(Ext , '.mat')||...
                        strcmp(Ext , '.hdr')
                        if strcmp(Ext , '.hdr')
                            ImageList={[Path , filesep , Name , '.img']};
                        else
                            ImageList={[Path , filesep , Name , Ext]};
                        end
                        return;
                    end
            elseif ~Subj(i).isdir
                break;
            end
        else
            continue;
        end
    end
    %Find 4D
    FirstChar=1;
    while FirstChar<=size(SubjName , 2)
        if strcmp(Prefix(1) , '*')
            Subj=dir([ParentDir , filesep  , '*' , SubjName(FirstChar:end) , Prefix(2:end)]);
        else
            Subj=dir([ParentDir , filesep ,  Prefix , SubjName(FirstChar:end) , '.*']);
        end
        
        if isempty(Subj)
            FirstChar=FirstChar+1;
        else
            if size(Subj,1)~=1
                errordlg(sprintf('Please ensure that there is just one %s file for %s' , ...
                    Prefix , SubjName));
                return;
            else
                break;
            end
        end
    end
    
    for i=1:size(Subj , 1)
        if ~strcmp(Subj(i).name , '.') && ~strcmp(Subj(i).name , '..')
            [Path , Name , Ext]=fileparts([ParentDir , filesep , Subj(i).name]);
            if (strcmp(Ext , '.nii') || strcmp(Ext , '.img') || ...
                    strcmp(Ext , '.txt') || strcmp(Ext , '.mat'))
                ImageList={[Path , filesep , Name , Ext]};
                return;
            end
        end
    end

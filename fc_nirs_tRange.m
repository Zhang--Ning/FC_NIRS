function [ outdata ] = fc_nirs_tRange(inputdata,tRange )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%tRange=str2num(tRange);
var_name=fieldnames(inputdata);
outdata=inputdata;
if length(tRange<3);
if ~isprocOD(var_name)
    rawdata=inputdata.rawdata;
    t=rawdata.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.procOD.dod=rawdata.d(tindex,:);
    outdata.procOD.t=t(tindex)-tRange(1);
    %outdata.procOD.dod=nirs_detrend(rawdata.d,p);
    %outdata.procOD.t=rawdata.t;
    return
elseif ~isprocConc(var_name)
    t=outdata.procOD.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.procOD.dod=outdata.procOD.dod(tindex,:);
    outdata.procOD.t=t(tindex)-tRange(1);    
else
    t=outdata.procConc.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.procConc.HbO=outdata.procConc.HbO(tindex,:);
    outdata.procConc.HbR=outdata.procConc.HbR(tindex,:);
    outdata.procConc.HbT=outdata.procConc.HbT(tindex,:);
    outdata.procConc.t=t(tindex)-tRange(1);  
end
elseif length(tRange>=3)
    if ~isprocOD(var_name)
    rawdata=inputdata.rawdata;
    t=rawdata.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.procOD.dod=rawdata.d(tindex,:);
    outdata.procOD.t=t(tindex)-tRange(1);
    %outdata.procOD.dod=nirs_detrend(rawdata.d,p);
    %outdata.procOD.t=rawdata.t;
    return
    elseif ~isprocConc(var_name)
    t=outdata.procOD.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.procOD.dod=outdata.procOD.dod(tindex,:);
    outdata.procOD.t=t(tindex)-tRange(1);    
    else
    t=outdata.procConc.t;
    tindex=(t>tRange(1))&(t<tRange(2));
    tindex=find(tindex==1);
    outdata.procConc.HbO=outdata.procConc.HbO(tindex,:);
    outdata.procConc.HbR=outdata.procConc.HbR(tindex,:);
    outdata.procConc.HbT=outdata.procConc.HbT(tindex,:);
    outdata.procConc.t=t(tindex)-tRange(1);  
end
    
end

%is exist procOD;
function [r]=isprocOD(var_name)
r=0;
x=strfind(var_name,'procOD');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end
%is exist procConc
function [r]=isprocConc(var_name)
r=0;
x=strfind(var_name,'procConc');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end

function [r]=israwConc(var_name)
r=0;
x=strfind(var_name,'rawConc');
for i=1:size(x,1)
    if ~isempty(x{i,1})
        r=1;
    end
end
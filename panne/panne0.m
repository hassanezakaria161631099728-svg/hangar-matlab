function [ba,geo,Troof1,Troof2,in1,in2,in3,in6,in7,in8]=panne0(hangarf,chapterI)
geo=readtable(hangarf,'sheet','geography attributes');
ba=readtable(hangarf,'sheet','building attributes');
in1=readtable(chapterI,'sheet','T1');
in2=readtable(chapterI,'sheet','T2');
in3=readtable(chapterI,'sheet','T3');
in6=readtable(chapterI,'sheet','T6');
in7=readtable(chapterI,'sheet','T7');
in8=readtable(chapterI,'sheet','T8');
Troof1=readtable(chapterI,'sheet','Troof1');
Troof2=readtable(chapterI,'sheet','Troof2');
end
%% end
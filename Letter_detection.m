function letter=readLetter(snap)

load NewTemplates % Loads the templates of characters in the memory.
snap=imresize(snap,[42 24]); % Resize the input image so it can be compared with the template's images.
RecordValue=[ ];

for n=1:length(NewTemplates)
    Correlation =corr2(NewTemplates{1,n},snap); % Correlation the input image with every image in the template for best matching.
    RecordValue=[RecordValue Correlation ]; % Record the value of correlation for each template's character.
end

Match=find(RecordValue==max(RecordValue)); % Find the index which correspond to the highest matched character.
display(Match);

% Alphabets listings.
if Match==1 || Match==2
    letter='A';
elseif Match==3 || Match==4
    letter='B';
elseif Match==5
    letter='C';
elseif Match==6 || Match==7
    letter='D';
elseif Match==8
    letter='E';
elseif Match==9
    letter='F';
elseif Match==10
    letter='G';
elseif Match==11
    letter='H';
elseif Match==12
    letter='I';
elseif Match==13
    letter='J';
elseif Match==14
    letter='K';
elseif Match==15
    letter='L';
elseif Match==16
    letter='M';
elseif Match==17
    letter='N';
elseif Match==18 || Match==19
    letter='O';
elseif Match==20 || Match==21
    letter='P';
elseif Match==22 || Match==23
    letter='Q';
elseif Match==24 || Match==25
    letter='R';
elseif Match==26
    letter='S';
elseif Match==27
    letter='T';
elseif Match==28
    letter='U';
elseif Match==29
    letter='V';
elseif Match==30
    letter='W';
elseif Match==31
    letter='X';
elseif Match==32
    letter='Y';
elseif Match==33
    letter='Z';
    %*-*-*-*-*
% Numerals listings.
elseif Match==34
    letter='1';
elseif Match==35
    letter='2';
elseif Match==36
    letter='3';
elseif Match==37 || Match==38
    letter='4';
elseif Match==39
    letter='5';
elseif Match==40 || Match==41 || Match==42
    letter='6';
elseif Match==43
    letter='7';
elseif Match==44 || Match==45
    letter='8';
elseif Match==46 || Match==47 || Match==48
    letter='9';
else
    letter='0';
end
end
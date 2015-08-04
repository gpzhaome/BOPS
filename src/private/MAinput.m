function [MAid, XMLsetupTemplate, fcut_coordinates, inputTrials, IKresultsDir, varargout] = MAinput(trialsList, varargin)
% Function asking input for MA 
%
% Copyright (C) 2014 Alice Mantoan, Monica Reggiani
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
%Get processing identifier 
dialogText = 'Select a processing identifier for the Muscle Analysis';
MAid = char(inputdlg(sprintf(dialogText)));


%Get template for the XML setup file
originalPath=pwd;
cd('..')
TemplatePath=[pwd filesep fullfile('Templates','MuscleAnalysis') filesep];
cd(originalPath)

[filename, pathname] = uigetfile([TemplatePath '*.xml'], 'Select XML Template for the setup file');

XMLsetupTemplate = [pathname filename];

%Definition of lowpass frequency cut off for filtering coordinates
num_lines = 1;
options.Resize='on';
options.WindowStyle='modal';
defValue{1}='6';

dlg_title='Choose the low-pass cut-off frequency for filtering the coordinates_file data ';
prompt ='lowpass_cutoff_frequency_for_coordinates (-1 disable filtering)';

answer = inputdlg(prompt,dlg_title,num_lines,defValue,options);

fcut_coordinates=str2num(answer{1});


%OPTIONAL:
if nargout>3
    
    %Selection of trials to elaborate from the list   
    [trialsIndex,v] = listdlg('PromptString','Select trials to elaborate:',...
        'SelectionMode','multiple',...
        'ListString',trialsList);
    
    inputTrials=trialsList(trialsIndex);
    
    %Get folder with Inverse Kinematics results to use for MA
    if nargout == 5           
        IKresultsDir = uigetdir(' ', 'Select folder with INVERSE KINEMATICS results to use');
    end
 
end   


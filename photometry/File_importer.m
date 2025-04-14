function beh_data = File_importer()
%import files
%clear variables
%
disp('import analog');
[behfile,behfilepath] = uigetfile ('*.csv');
behfullpath = append(behfilepath,behfile);
disp('analog file is: ');
disp (behfullpath)
disp('import photometry');
[photfile,photfilepath] = uigetfile ('*.csv');
photfullpath = append(photfilepath,photfile);
disp('photometry file is: ')
disp(photfullpath);
%convert file to readable array and nix unusable columns
%analog data import
beh_read = readmatrix(behfullpath);
beh_readA = beh_read(1:end, 1:1); %splits out usable columns
%beh_readDG = beh_read(1:end, 4:7); for licks
beh_readDG = beh_read(1:end, 4:6);
beh_data = cat(2,beh_readA, beh_readDG); %concatenates columns
%photometry data import
photometry_read = readmatrix(photfullpath);
phot_readA = photometry_read(1:end, 1:1);
phot_readC = photometry_read(1:end, 3:3);
photometry_data = cat(2,phot_readA, phot_readC);
%clean up vars
clear beh_read beh_readA beh_readDG behfile beh_fullpath phot_readA phot_readC photfile photfilepath;
clear photfullpath photometry_read behfilepath behfullpath
end
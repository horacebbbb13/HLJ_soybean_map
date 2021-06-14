function PontusStat=Le_AccToolPontus(Matrix)

%% Citation:
% Olofsson P, Foody GM, Stehman SV, Woodcock CE (2013) 
% Making better use of accuracy data in land change studies: estimating accuracy and area and quantifying uncertainty using stratified estimation. 
% Remote Sensing of Environment, 129:122-131 
% Modified from http://people.bu.edu/olofsson/AccTool.m

%% Get error matrix
%S.M=[1,1,2,1;2,2,4,2;3,3,6,3];
%S.q=2;
S.M=Matrix;
S.q=size(Matrix,1)-1;
for i = 1:S.q
   W(i) = S.M(i,S.q+2)/sum(S.M(1:S.q,S.q+2));
end
Ws = [W sum(W)];
n_xp = sum(S.M(1:S.q,1:S.q),2);
M_1 = [n_xp; 0];
S.M = [S.M(:,1:S.q) M_1 S.M(:,S.q+2) Ws'];
n_px = sum(S.M(1:S.q,1:S.q),1);
M_2 = [n_px sum((S.M(1:S.q,S.q+1))) sum(S.M(1:S.q,S.q+2)) sum(W(1:S.q))];
S.M = [S.M(1:S.q,:);M_2];

%% Calculate accuracy, area, and CI when OK pushed
if isempty(S.M)
   errordlg('You need to populate the error matrix!')
   S.M = zeros(S.q+1,S.q+3);
end
Wh = S.M(1:S.q,S.q+3);
cells = S.M(1:S.q,1:S.q);
sm = sum(cells,2);
VO=0;
for i = 1:S.q
   S.p(:,i) =  Wh.*cells(:,i)./sm;
   V(i)  = sum(Wh.^2.*(((1-cells(:,i)./sm).*cells(:,i)./sm)./(sm-1)));
   U=cells(i,i)/S.M(end,i);
   VO = VO+Wh(i).^2.*U*(1-U)./(sm(i)-1);
   VU(i)=(U*(1-U))./(sm(i)-1);
   %VP(i)=(1/
end
% Reference and map area proportions
p_r = sum(S.p,1); p_r = p_r';
p_m = sum(S.p,2); 

% Estimated areas adjusted for classification errors 
A_tot = S.M(S.q+1,S.q+2);
S.A   = round(A_tot.*p_r);

% Area +- margin of error
SE_p  = sqrt(V);
S.MoE = round(A_tot*1.96*SE_p); S.MoE = S.MoE';
A_    = strcat(num2str(S.A),' +- ',num2str(S.MoE));

% Accuracy measures
S.over = sum(diag(S.p));
S.over_p=1.96*sqrt(VO);
S.user = diag(S.p)./p_m;
S.user_p=1.96*sqrt(VU' );
S.prod = diag(S.p)./p_r;

PontusStat=[S.A S.MoE [S.over;S.over] S.user S.prod [S.over_p;S.over_p] S.user_p];

% %% plot
% points = S.A./S.M(1:S.q,S.q+2);assignin('base','points',points)
% err = S.MoE./S.M(1:S.q,S.q+2);assignin('base','MoE',S.MoE)
% if isequal(err,zeros(S.q,1)) | max(isnan(points))==1
%     errordlg('No errorbars to display');
% else
%     S.f2 = figure;
%     set(S.f2,'Name','Error Plot','NumberTitle','off','Menubar','none');
%     errorbar(points, err,'o'); 
%     hold on; 
%     plot(points,'o','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',8);
%     plot(0:S.q+1,ones(S.q+2,1),'k')
%     ylim([floor(min(points)-max(err)) ceil(max(points)+max(err))])
%     set(gca,'XTick',1:S.q)
%     set(gca,'XTickLabel',{'Crop','NoneCrop'})
%     ylabel 'Area \pm margin of error (normalized by mapped area)'
% end

% %%% Export variables to workspace %%%   
% function [] = expCall(varargin)
% S = varargin{3};
% S.M = guidata(S.f);
% def = {'ErrorMatrix','AreaPropMatrix','Areas','OverUserProd'};
% 
% assignin('base',def{1},S.M)
% assignin('base',def{2},S.p)
% assignin('base',def{3},[(1:S.q)' S.A S.MoE])
% assignin('base',def{4},[(1:S.q)' repmat(S.over,S.q,1) S.user S.prod])
% 
% msgtext  = cellstr('The following variables were exported to the workspace: ');
% msgspace = cellstr(' ');
% msgbox([msgtext msgspace def])
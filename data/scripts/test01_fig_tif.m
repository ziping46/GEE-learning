clear;clc;
file = 'source\land_site06.tif';
[A,R]= geotiffread(file); %��ȡtif��դ������
year = [1990 2000 2010 2019]; 
H = nan(length(year),1);
mymap = [255,0,0
    85,255,0
    255,255,0
    115,223,255
    38,115,0
    255,190,232
    128,222,153
    0,92,230]/255; % ��ɫ
figure(1);
set(gcf,'Position',[200,200,800,400]);%��������Ļͼ��λ�úʹ�С
for i = 1:length(year)
    subplot(3,4,i)
    img = A(:,:,year(i)-1985);%��ѡ��Ҫ��������
    img(img==0) =8; % 0 Ҳ����������ʵ0��û�з���������ע��һ��
    H(i) = imagesc(img);%��ʾͼƬ
    colormap(mymap) %���벻ͬ�������Ͳ�ͬ����ɫ���Լ�ѡ�Լ���Ҫ����ɫ
%     colorbar('Ticks',[1  2  3  4 ,5 ,6 ,7, 8],...
%     'TickLabels',{'����','�ײ�','̲Ϳ','ˮϵ','��','����','����','��ֳ��'}) %
%     ���Ǽ�ͼ��������Ҫ,֮���Լ����ϣ�Ϊ�˺ÿ����ѣ����Լ���Ե��
    title([num2str(year(i)),'��'],'FontSize',12,'FontWeight','bold') % ��С�������
    set(gca,'xtick',[],'ytick',[],'FontSize',12,'FontWeight','bold')
    
end
suptitle('XXX-�ص�') %���ܱ���
set(gca,'FontSize',12,'FontWeight','bold');%�����ܱ���Ĵ�С����ϸ
%% �Լ��ử�����
subplot(3,4,[5,6,7,8]) %�������ͼ����ʵ��һ����2��4�У���һ�е�4�л�tif,�ڶ��е�4����ͼ���һ�����������
area = nan(34,9); % ��������������ɵ�34��*9�е����飬������ʱ���ÿ�����͵����
for i = 1:34
    img = A(:,:,i);
    area(i,1) = i+1985; %��һ�������
    for j = 1:8
        area_i = sum(sum(img==j))*900/1e6;% ת�� km2
        area(i,j+1) = area_i;
    end
end
h= plot(area(:,1),area(:,[2,3])); % ֻ�������ֺ��ײݵ������1��������,2�����ײ�
set(h(1) , 'linestyle','-','LineWidth',2,'Color',[1 0 0]) % ����XXX-A�ߵ���ʽ
set(h(2), 'linestyle','-','LineWidth',2,'Color',[0 0.5 0])% ����XXX-B�ߵ���ɫ
set(gca,'xlim',[1985 2020]) % ���� X ��ķ�Χ
set(gca,'xtick',1985:5:2020,'FontSize',12,'FontWeight','bold') %���� X ��Ŀ̶Ⱥ���ʽ
ylabel('area/km^2','FontSize',12,'FontWeight','bold') %���� Y �� ��ǩ��ʽ
legend(h,'Location','northwest',{'XXX-A','XXX-B'},'FontSize',12,'FontWeight','Bold','box','off') %ͼ������ʽ
% set(gca,'position',[0.15 0.1 0.75 0.4 ]) % 

subplot(3,4,[9,10,11,12]) 
data = area([1990 2000 2010 2018]-1985, 2:end );
data = round(data,2);
uitable('data',data,'ColumnFormat',{'char'},'Position',[20 20 600 290],'Rowname',{1990 2000 2010 2018},'Columnname',{'����','�ײ�','̲Ϳ','ˮϵ','��','����','����','��ֳ��'});

format short g
clear all; close all; clc;
darkFigure();
catImage = im2double(imread('github_icon.png'));
[h, w, ~] = size(catImage);
imshow(catImage);

%% Mouse input
xlabel ('Select at most 200 points along the outline', 'FontName', '�L�n������', 'FontSize', 14);
[ ctrlPointX, ctrlPointY ] = ginput(200);
ctrlPointList = [ctrlPointX ctrlPointY];
clickedN = size(ctrlPointList,1);

promptStr = sprintf('%d points selected', clickedN);
xlabel (promptStr, 'FontName', '�L�n������', 'FontSize', 14);

%% ===================================================
% Part 1 (a)

%% Calculate Bzier curve (Your efforts here)
%outlineVertexList = ctrlPointList; %Enrich outlineVertexList
sample_size = 40;
t = linspace(0, 1, sample_size); % [0, 1] ���� sample_size
M = [-1 3 -3 1; 3 -6 3 0; -3 3 0 0; 1 0 0 0];

outlineVertexList = [];
for verI = 1:3:clickedN
    G = zeros(4, 2);
    for verJ = 0:3
        xx = mod(verI, clickedN)+1;
        G(verJ+1, :) = ctrlPointList(xx, :);
    end
    for samK = 1:sample_size
        T = [t(samK).^3, t(samK).^2, t(samK), 1];
        outlineVertexList = [outlineVertexList; T*M*G];
    end
end
%% Draw and fill the polygon
drawAndFillPolygon( catImage, ctrlPointList, outlineVertexList, true, true, true ); %ctrlPointScattered, polygonPlotted, filled

%% ===================================================
% Part 1 (b)

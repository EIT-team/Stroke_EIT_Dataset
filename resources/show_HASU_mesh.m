load('Mesh_example.mat');

%%
trep = triangulation(Mesh.Tetra, Mesh.Nodes);
[Triangle_Boundary, Nodes_Boundary] = freeBoundary(trep);


%%
hold on




h= trisurf(Triangle_Boundary, Nodes_Boundary(:,1), Nodes_Boundary(:,2), Nodes_Boundary(:,3));


% facenb=faceneighbors(double(mesh.Tetra(:,1:4)), 'surface');
% TR=TriRep(facenb, mesh.Nodes(:,1),mesh.Nodes(:,2),mesh.Nodes(:,3));
%figure;
% h=trimesh(TR);
set(h,'EdgeColor',[0.3,0.3,0.3],'FaceColor','w','FaceAlpha',0.5);
% set(h,'EdgeColor',[100,143,229]/256,'EdgeAlpha',0.5);
% set(h,'EdgeAlpha',0.5);
% set(h,'FaceColor','None');
daspect([1,1,1]);



plot3(Mesh.elec_pos(:,1),Mesh.elec_pos(:,2),Mesh.elec_pos(:,3),'.','MarkerSize',50);




for iElec = 1:size(Mesh.elec_pos,1)
    text(Mesh.elec_pos(iElec,1),Mesh.elec_pos(iElec,2),Mesh.elec_pos(iElec,3),Mesh.elec_label(iElec),'FontWeight','Bold','FontSize',28); % plots numbers on electrode pos
end


hold off







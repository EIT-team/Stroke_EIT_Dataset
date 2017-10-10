% Visualise the electrode locations on an example head mesh

% load the mesh structure 
load('Mesh_example.mat');

%% Convert to surface triangles
trep = triangulation(Mesh.Tetra, Mesh.Nodes);
[Triangle_Boundary, Nodes_Boundary] = freeBoundary(trep);

%% plot surface with electrode locations and labels
hold on

h= trisurf(Triangle_Boundary, Nodes_Boundary(:,1), Nodes_Boundary(:,2), Nodes_Boundary(:,3));
set(h,'EdgeColor',[0.3,0.3,0.3],'FaceColor','w','FaceAlpha',0.5);
daspect([1,1,1]);

plot3(Mesh.elec_pos(:,1),Mesh.elec_pos(:,2),Mesh.elec_pos(:,3),'.','MarkerSize',50);

for iElec = 1:size(Mesh.elec_pos,1)
    text(Mesh.elec_pos(iElec,1),Mesh.elec_pos(iElec,2),Mesh.elec_pos(iElec,3),Mesh.elec_label(iElec),'FontWeight','Bold','FontSize',28); % plots numbers on electrode pos
end

hold off
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')

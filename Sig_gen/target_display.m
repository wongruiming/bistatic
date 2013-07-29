
function H = target_display( posTz)

if size(posTz,1) == 1
    mi = posTz;
    ma = posTz;
else
    mi = min( posTz );
    ma = max( posTz );
end
figure(1)
axis( [ mi(1)-3 ma(1)+3 mi(2)-3 ma(2)+3 mi(3)-3 ma(3)+3 ] );
axis equal
grid on
xlabel('Axis z1 (m)');
ylabel('Axis z2 (m)');
zlabel('Axis z3 (m)');
title( '3D illustration of the point scatterers' );
hold on
H = newplot;
axes(H);
plot3( posTz(:,1), posTz(:,2), posTz(:,3),'.' );



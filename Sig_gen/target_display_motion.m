
function target_display_motion(posTz,Tob,N,numscat,Rphi,Rni,Rmu,Po,Iv,v,...
    bi_static,Po_Tx)

% Create courser time step 
N_course = round(N/10);
t = linspace( -Tob/2, Tob/2, N_course );

% Generate the motion of the scatterers
ptTx = calc_pos( posTz, t, numscat, Rphi, Rni, Rmu ); 

% contains the coordnates of point O on the target 
flightpath = calc_traj( t, Po, Iv, N_course, v );   

% Put the scatterers motions together
ptTx_combi = ptTx + repmat(flightpath,1,numscat);
RxPosn = zeros(3);

% the rest of the display codes
% if size(posTz,1) == 1
%     mi = posTz;
%     ma = posTz;
% else
%     mi = min( posTz );
%     ma = max( posTz );
% end
figure(2)
% axis( [ mi(1)-3 ma(1)+3 mi(2)-3 ma(2)+3 mi(3)-3 ma(3)+3 ] );

for i_step = 1:N_course
    plot( RxPosn(1), RxPosn(2),'r^' );
    text(RxPosn(1)+0.3,RxPosn(2),'Receiver')
    if bi_static==2, 
        hold on
        plot( Po_Tx(1),Po_Tx(2),'b^' );
        text(Po_Tx(1)+0.3,Po_Tx(2)+1,'Transmitter')
        hold off
    end
    hold on
    plot( ptTx_combi(i_step,1:3:end), ptTx_combi(i_step,2:3:end),'-' );
    hold off
    axis( [ -3 15+3 -3 30+3 ] );
    axis normal
% axis equal
    grid on
    xlabel('Axis z1 (m)');
    ylabel('Axis z2 (m)');
    title( 'Top view of test layout' );
    pause(0.1)
end




function pt = calc_pos( po1, t, n, Rphi, Rni, Rmu )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Copyright
%%%
%Date
%July 2009
%%%
%Author
%Marco Martorella
%%%
%Affiliation
%Dipartimento di ingegneria dell'Informazione, via Caruso 16, 56122 Pisa,
%italy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


pt=[];            % In questo modo si definisce la variabile "pt" come una matrice.

for m=1:n,
    
   [T ptn]=ode45(@eq_diff,t,po1(m,1:3)); % position of the m-th scatterer with respect to the target's reference system
   
   ptn = (( Rmu*Rni*Rphi )*ptn.').'; % position of the m-th scatterer with respect to the radar's reference system
     
      
   pt=cat(2,pt,ptn); % matrix containing all the scatterer's positions for all time instants      

end


draw(X,Y):- X1 is X+1 ,dim(X1,Y),!.

draw(X,Y):- dim(_,Y),write('\n'),X1 is X+1,draw(X1,0),!. 

draw(X,Y):- bomb([X,Y]),write(' x '),Y1 is Y+1,draw(X,Y1),!.

draw(X,Y):- star([X,Y]),write(' * '),Y1 is Y+1,draw(X,Y1),!.

draw(X,Y):- end([X,Y]),write(' e '),Y1 is Y+1,draw(X,Y1),!.

draw(X,Y):- start([X,Y]),write(' s '),Y1 is Y+1,draw(X,Y1),!.

draw(X,Y):- write(' . '),Y1 is Y+1,draw(X,Y1),!.


move([X,Y],[NX,Y],Star,NS,down):-NX is X+1,\+ dim(NX,_),NX>=0,
			\+ bomb([NX,Y]),(star([NX,Y])-> NS is Star+1;NS is Star).
			
move([X,Y],[NX,Y],Star,NS,up):-NX is X-1,\+ dim(NX,_),NX>=0,
			\+ bomb([NX,Y]),(star([NX,Y])-> NS is Star+1;NS is Star).
			
move([X,Y],[X,NY],Star,NS,right):-NY is Y+1,\+ dim(_,NY),NY>=0,
			\+ bomb([X,NY]),(star([X,NY])-> NS is Star+1;NS is Star).
			
move([X,Y],[X,NY],Star,NS,left):-NY is Y-1,\+ dim(_,NY),NY>=0,
			\+ bomb([X,NY]),(star([X,NY])-> NS is Star+1;NS is Star).


play(Stars,Moves):- draw(0,0),
				start([X,Y]),run([X,Y],0,Stars,[],Moves,[[X,Y]]).

run([X,Y],Stars,Stars,Moves,Moves,_):- end([X,Y]).

run([X,Y],Stars,NStars,Moves,LMoves,Vis):-
				move([X,Y],[NX,NY],Stars,NS,Way),
				\+ member([NX,NY],Vis),
				append([[NX,NY]],Vis,NVisited),
				append(Moves,[Way],NMoves),
				run([NX,NY],NS,NStars,NMoves,LMoves,NVisited).
				



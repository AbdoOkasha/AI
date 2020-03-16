getProcess([],_,[],Finished,Finished).
getProcess([H|T],CurrAvail,NewAvail,Finished,NF):-(canRelease(H,CurrAvail,Finished,NF) -> release(H,NewAvail,CurrAvail),!
							 ;getProcess(T,CurrAvail,NewAvail,Finished,NF)),!. %the first getProcess is for tracing purpose and will be removed later

%main_one
dummyGetProcess([],_,NF1,NF1).
dummyGetProcess([_|T],CurrAvail,Finished,NF):- processes(X),getProcess(X,CurrAvail,NewAvail,Finished,NF1),
								(NewAvail \==[]),dummyGetProcess(T,NewAvail,NF1,NF),!.

file("E:/Downloads/FCI/AI/p2(test).pl"). %directory of the data file

safe_state(NF):-file(FILE),consult(FILE), % instead of loading file each time
		processes(X),available_resources(Y),dummyGetProcess(X,Y,[],NF).


canRelease(P,Resources,Finished,NF):- countElementsInList(P,Z,Finished),(Z == 0 -> 
									  (requested(P,X) -> checkResources(X,Resources);
									  allocated(P,_)),append(Finished,[P],NF),!),!.  % X is the requested resources

checkResources([],_).

checkResources([NeedH|NeedT],Resources):-countElementsInList(NeedH,NeedX,[NeedH|NeedT]),  %count duplication of needh in the list
										 getAvailableResources(NeedH,X,Resources),
									 	 (NeedX =< X ),
								 		 checkResources(NeedT,Resources),!.


getAvailableResources(R,X,[H|T]):- append([],H,[TmpH|TmpT]),
								   (TmpH==R -> X is TmpT,!;
								   getAvailableResources(R,X,T)).
							 
				
				
generate(L,L).				

release(_,[],[]).

release(P,NewAvail,[AvailH|AvailT]):- (allocated(P,Alloc) -> 0=0 ;true,generate(Alloc,[])),
									  append([],AvailH,[TmpH|TmpT]),
									  countElementsInList(TmpH,X2,Alloc),
									  TmpAns is TmpT+X2,
									  release(P,TmpAvail,AvailT),
									  append([[TmpH,TmpAns]],TmpAvail,NewAvail),!.
									  
									  
										
									  
									
countElementsInList(_,0,[]):- true,!.
	
countElementsInList(R,X,[H|T]):- countElementsInList(R,C,T),
								 (R==H -> X is (1 + C) ; X is C),!.
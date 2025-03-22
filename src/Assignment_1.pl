:- consult('league_data.pl'). % Include the provided data file
% Task 1  (Tail recursive solution)
players_in_team(Team, L):-  % an interface function to be called through user
    players_Acc(Team, L, []), !.  % deh b2a feha el logic nfso

players_Acc(Team, L, Acc):-
    player(Player, Team, _), %search fe el facts 3la player fe team (Team)
    \+ custom_member(Player, Acc), %since eni bst5dm recursion lazem a3ml checker 3lshan myb2ash feh duplicates
    players_Acc(Team, L, [Player|Acc]). %el recursion call b2ol feha eni 7tet a player fe el accumulator

players_Acc(_, Acc, Acc). %base case b5li feha el result(L) zy el accumulator

%-------------------------------------------------
% Task 2
team_count_by_country(Country, Count) :-  %interface predicate
    gather_teams_by_country(Country, [], TeamList),  %bt3ml list feha every team in the country
    custom_length(TeamList, Count), !.  %bt7sb el length bta3 el list(teams)

gather_teams_by_country(Country, Seen, FinalList) :- %logic predicate
%btgeeb el team that belong to the givne country w b7otha fe el list
    team(Team, Country, _),
    \+ custom_member(Team, Seen), !,  %duplication checking
    gather_teams_by_country(Country, [Team | Seen], FinalList).

gather_teams_by_country(_, Teams, Teams). %base case

custom_length([], 0). %base case if list is empty
custom_length([_|Tail], Length) :- %bt3ml recursive call elshan t3ml looping through the list
    custom_length(Tail, TailLength),
    Length is TailLength + 1.

custom_member(Element, [Element|_]). %base case
custom_member(Element, [_|Tail]) :- %bt3ml check lw el element is a member of the list
    custom_member(Element, Tail).

%-------------------------------------------------
%Task 3
most_successful_team(Team) :-  %interface predicate
   wins_helper(0,none, Team), !. %bt3ml call le wins_helper w bt5li el maxWin=0 and MaxTeam=none

wins_helper(MaxWin,MaxTeam,Team):-
  team(CurrTeam,_,Win),  %bt3ml looping 3la el teams w tgeeb el number of wins bta3thom
  Win>MaxWin,  %bt3ml comparison between Win and maxWin
  wins_helper(Win,CurrTeam,Team). %lw true t5li el MaxWin=Win lw flase tshof team tani

wins_helper(MaxWin,Team,Team):-  %base case lw el Team=Maxteam
    team(_,_,Win),  %b3ml one last check en mfeesh team el wins bta3to a3la mn el maxTeam
    \+(Win>MaxWin).



%-------------------------------------------------
%Task 4
matches_of_team(Team,L):-
    matches_helper(Team,L,[]), !.

matches_helper(Team,L,Acc):-  %btdor 3la match ykon feh el Team dah as the main team or home
    match(Team,Opponent,TeamScore,OpponentScore),
    \+ custom_member((Team,Opponent,TeamScore,OpponentScore),Acc),
    matches_helper(Team,L,[(Team,Opponent,TeamScore,OpponentScore)|Acc]).

matches_helper(Team, L, Acc):-   %btdor 3la match ykon feh el Team dah as the opponent team or away
    match(Opponent,Team,OpponentScore,TeamScore),
    \+ custom_member((Opponent,Team,OpponentScore,TeamScore),Acc),
    matches_helper(Team,L,[(Opponent,Team,OpponentScore,TeamScore)|Acc]).

matches_helper(Team, Acc, Acc).  %base case




%-------------------------------------------------
%Task 5
% a predicate to count all matches a team has played
num_matches_of_team(Team, N) :-
    count_matches(Team, [], 0, N).

count_matches(Team, Seen, C, N) :-
    (match(Team, Opp, S1, S2) ; match(Opp, Team, S1, S2)),  %btshof lw fe match el team dah l3b feh either as home or away team
    \+ custom_member(match(Team, Opp, S1, S2), Seen),
    NewC is C + 1,
    count_matches(Team, [match(Team, Opp, S1, S2) | Seen], NewC, N).  %recursive call
count_matches(_, _, N, N). %base case
%-------------------------------------------------
%Task 6
% a predicate to give the highest-scoring player
top_scorer(Player) :-
    goals(Player, Goals), %btgeeb a player w el goals bta3thom
    \+ (goals(_, OtherGoals), OtherGoals > Goals). %btdor 3la player 3ndo goals a3la mn el current player
%-------------------------------------------------
%Task 7
% Task 7: Find the most common position in a specific team
most_common_position_in_team(Team, Pos) :-
    extract_positions(Team, RoleList), %gtgeeb el roles bta3t kol el players in the Team
    tally_roles(RoleList, RoleCounts), %counts number of players per role w bt7tohm fe el RoleCounts
    highest_count(RoleCounts, MaxOccurrence), %btgeeb el role with the highest count
    first_role_with_max(RoleCounts, MaxOccurrence, Pos). %return el most common position

extract_positions(Team, Roles) :-
    player(_, Team, Role), % btgeeb ay player fe el team w bt7ot el role bta3o fe el list
    gather_positions(Team, [Role], Roles).

gather_positions(Team, Collected, Roles) :-
    player(_, Team, Role), % btgeeb el roles mn el facts
    not_in_list(Role, Collected), % btcheck lw el role msh mawgod fel list
    gather_positions(Team, [Role|Collected], Roles).
gather_positions(_, Roles, Roles). % Base case lw el list complete

not_in_list(_, []). % lw el list fadyah, 5alas msh mawgod
not_in_list(X, [Y|T]) :-
    X \== Y, % lw el role msh equal le ay role fe el list
    not_in_list(X, T).

tally_roles([], []). % Base case lw msh feh roles
tally_roles([Role|Rest], RoleCounts) :-
    tally_roles(Rest, TempCounts), % Recursive call
    update_count(Role, TempCounts, RoleCounts). % Update el count

update_count(Role, [], [(Role, 1)]). % lw el role msh mawgod abl keda, start with 1
update_count(Role, [(Role, Count)|Tail], [(Role, NewCount)|Tail]) :-
    NewCount is Count + 1. % lw el role mawgod, zwd el count b 1
update_count(Role, [(OtherRole, Count)|Tail], [(OtherRole, Count)|NewTail]) :-
    Role \== OtherRole, % lw msh nafs el role, continue checking
    update_count(Role, Tail, NewTail).

highest_count([(_, Count)], Count). % Base case lw feh wa7ed bas
highest_count([(_, C1), (_, C2)|Rest], MaxCount) :-
    (C1 >= C2 ->
        highest_count([(_, C1)|Rest], MaxCount) % lw el C1 akbar aw equal C2
    ;
        highest_count([(_, C2)|Rest], MaxCount) % lw C2 akbar
    ).

first_role_with_max([(Role, Count)|_], Max, Role) :-
    Count =:= Max. % lw el role da ma3ah el Max Count
first_role_with_max([_|Rest], Max, Role) :-
    first_role_with_max(Rest, Max, Role). % lw msh equal, continue
%-------------------------------------------------








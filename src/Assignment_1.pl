:- consult('league_data.pl'). % Include the provided data file
% Task 1
players_in_team(Team, L):-
    players_Acc(Team, L, []), !.

players_Acc(Team, L, Acc):-
    player(Player, Team, _),
    \+ member(Player, Acc),
    players_Acc(Team, L, [Player|Acc]).

players_Acc(_, Acc, Acc).

%-------------------------------------------------
% Task 2
team_count_by_country(Country, Count) :-
    gather_teams_by_country(Country, [], TeamList),
    length(TeamList, Count),!.

gather_teams_by_country(Country, Seen, FinalList) :-
    team(Team, Country, _),
    \+ member(Team, Seen),!,

    gather_teams_by_country(Country, [Team | Seen], FinalList).

gather_teams_by_country(_, Teams, Teams).

%-------------------------------------------------
%Task 3
wins_helper(MaxWin,MaxTeam,Team):-
  team(CurrTeam,_,Win),
  Win>MaxWin,
  wins_helper(Win,CurrTeam,Team).

wins_helper(MaxWin,Team,Team):-
    team(_,_,Win),
    \+(Win>MaxWin).

most_successful_team(Team) :-
   wins_helper(0,none, Team), !.

%-------------------------------------------------
%Task 4
matches_helper(Team,L,Acc):-
    match(Team,Opponent,TeamScore,OpponentScore),
    \+ member((Team,Opponent,TeamScore,OpponentScore),Acc),
    matches_helper(Team,L,[(Team,Opponent,TeamScore,OpponentScore)|Acc]).

matches_helper(Team, L, Acc):-
    match(Opponent,Team,OpponentScore,TeamScore),
    \+ member((Opponent,Team,OpponentScore,TeamScore),Acc),
    matches_helper(Team,L,[(Opponent,Team,OpponentScore,TeamScore)|Acc]).

matches_helper(Team, Acc, Acc).

matches_of_team(Team,L):-
    matches_helper(Team,L,[]), !.


%-------------------------------------------------
%Task 5

%-------------------------------------------------
%Task 6

%-------------------------------------------------
%Task 7
% Task 7: Find the most common position in a specific team
most_common_position_in_team(Team, Pos) :-
    extract_positions(Team, RoleList),
    tally_roles(RoleList, RoleCounts),
    highest_count(RoleCounts, MaxOccurrence),
    first_role_with_max(RoleCounts, MaxOccurrence, Pos).

extract_positions(Team, Roles) :-
    player(_, Team, Role),
    gather_positions(Team, [Role], Roles).

gather_positions(Team, Collected, Roles) :-
    player(_, Team, Role),
    not_in_list(Role, Collected),
    gather_positions(Team, [Role|Collected], Roles).
gather_positions(_, Roles, Roles).

not_in_list(_, []).
not_in_list(X, [Y|T]) :-
    X \== Y,
    not_in_list(X, T).

tally_roles([], []).
tally_roles([Role|Rest], RoleCounts) :-
    tally_roles(Rest, TempCounts),
    update_count(Role, TempCounts, RoleCounts).

update_count(Role, [], [(Role, 1)]).
update_count(Role, [(Role, Count)|Tail], [(Role, NewCount)|Tail]) :-
    NewCount is Count + 1.
update_count(Role, [(OtherRole, Count)|Tail], [(OtherRole, Count)|NewTail]) :-
    Role \== OtherRole,
    update_count(Role, Tail, NewTail).

highest_count([(_, Count)], Count).
highest_count([(_, C1), (_, C2)|Rest], MaxCount) :-
    (   C1 >= C2 ->
        highest_count([(_, C1)|Rest], MaxCount)
    ;   highest_count([(_, C2)|Rest], MaxCount)
    ).

first_role_with_max([(Role, Count)|_], Max, Role) :-
    Count =:= Max.
first_role_with_max([_|Rest], Max, Role) :-
    first_role_with_max(Rest, Max, Role).

%-------------------------------------------------








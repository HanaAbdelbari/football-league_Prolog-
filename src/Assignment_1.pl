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
    findall(Team, team(Team, Country, _), Teams),
    length(Teams, Count).
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

%-------------------------------------------------








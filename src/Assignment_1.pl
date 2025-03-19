:- consult('league_data.pl'). % Include the provided data file
% Task 1
players_in_team(Team, L):-
    players_Acc(Team, L, []), !.

players_Acc(Team, [Player|Rest], Acc):-
    player(Player, Team, _),
    \+ member(Player, Acc),
    players_Acc(Team, Rest, [Player|Acc]).

players_Acc(_, [], _).

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

%-------------------------------------------------
%Task 5

%-------------------------------------------------
%Task 6

%-------------------------------------------------
%Task 7

%-------------------------------------------------








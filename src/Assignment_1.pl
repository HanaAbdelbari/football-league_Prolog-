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
%-------------------------------------------------









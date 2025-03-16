:- consult('league_data.pl'). % Include the provided data file
% Task 1
players_in_team(Team, Player) :-
    player(Player, Team, _).
% Task 2
team_count_by_country(Country, Count) :-
    findall(Team, team(Team, Country, _), Teams),
    length(Teams, Count).

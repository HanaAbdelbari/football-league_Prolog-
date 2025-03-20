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
num_matches_of_team(Team, N) :-
    findall(Match, (match(Team, _, _, _) ; match(_, Team, _, _)), Matches),
    length(Matches, N).
%-------------------------------------------------
%Task 6

%-------------------------------------------------
%Task 7
% If there is a tie, choose the position that appears first in the dataset.
most_common_position_in_team(Team, MostCommonPosition) :-
    get_all_positions(Team, Positions),
    count_positions(Positions, PositionCounts),
    find_max_count(PositionCounts, MaxCount),

    member((MostCommonPosition, MaxCount), PositionCounts).

get_all_positions(Team, Positions) :-
    findall(Position, player(_, Team, Position), Positions).

count_positions([], []).
count_positions([Position|Rest], PositionCounts) :-
    count_positions(Rest, TempCounts),
    (   select((Position, Count), TempCounts, NewTempCounts) ->
        NewCount is Count + 1,
        PositionCounts = [(Position, NewCount)|NewTempCounts]
    ;   PositionCounts = [(Position, 1)|TempCounts]
    ).

find_max_count([(_, Count)], Count).
find_max_count([(_, Count1), (_, Count2)|Rest], MaxCount) :-
    (   Count1 >= Count2 ->
        find_max_count([(_, Count1)|Rest], MaxCount)
    ;   find_max_count([(_, Count2)|Rest], MaxCount)
    ).
%-------------------------------------------------








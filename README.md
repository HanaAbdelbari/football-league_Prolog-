# Prolog Football League Analysis

## Overview
This project is a Prolog program designed to analyze data from a football league. It uses a set of facts about teams, players, matches, and goals to answer specific questions about the league. The program is implemented in Prolog and avoids using any built-in predicates, relying instead on custom implementations for list manipulation, counting, and searching.

The project is part of an assignment for the **Artificial Intelligence** course at **Cairo University, Faculty of Computers & Artificial Intelligence**.

---

## Project Structure

### Files
1. **`league_data.pl`**:
    - Contains the facts about teams, players, matches, and goals.
    - Example facts:
      ```prolog
      team(barcelona, spain, 5).
      player(messi, barcelona, forward).
      match(barcelona, real_madrid, 3, 2).
      goals(messi, 10).
      ```

2. **`Assignment_1.pl`**:
    - Contains the Prolog code to solve the tasks outlined in the assignment.
    - Implements custom predicates to avoid using built-in functions.

---

## Tasks Implemented

The program implements the following tasks:

### 1. **List of Players in a Team**
- **Predicate**: `players_in_team/2`
- **Description**: Retrieves a list of all players in a specific team.
- **Example Query**:
  ```prolog
  ?- players_in_team(barcelona, L).
  L = [messi, ter_stegen, de_jong].
  ```

### 2. **Count Teams from a Specific Country**
- **Predicate**: `team_count_by_country/2`
- **Description**: Counts how many teams are from a specific country.
- **Example Query**:
  ```prolog
  ?- team_count_by_country(spain, N).
  N = 2.
  ```

### 3. **Team with the Most Championship Titles**
- **Predicate**: `most_successful_team/1`
- **Description**: Finds the team with the most championship titles.
- **Example Query**:
  ```prolog
  ?- most_successful_team(T).
  T = bayern_munich.
  ```

### 4. **List Matches of a Specific Team**
- **Predicate**: `matches_of_team/2`
- **Description**: Lists all matches where a specific team participated.
- **Example Query**:
  ```prolog
  ?- matches_of_team(barcelona, L).
  L = [(barcelona, real_madrid, 3, 2), (liverpool, barcelona, 2, 2)].
  ```

### 5. **Count Matches of a Specific Team**
- **Predicate**: `num_matches_of_team/2`
- **Description**: Counts all matches where a specific team participated.
- **Example Query**:
  ```prolog
  ?- num_matches_of_team(barcelona, N).
  N = 2.
  ```

### 6. **Top Goal Scorer in the Tournament**
- **Predicate**: `top_scorer/1`
- **Description**: Finds the top goal scorer in the tournament.
- **Example Query**:
  ```prolog
  ?- top_scorer(P).
  P = ronaldo.
  ```

### 7. **Most Common Position in a Specific Team**
- **Predicate**: `most_common_position_in_team/2`
- **Description**: Finds the most common position in a specific team.
- **Example Query**:
  ```prolog
  ?- most_common_position_in_team(barcelona, Pos).
  Pos = forward.
  ```

### Bonus Task: **Control Unneeded Backtracking**
- **Description**: Ensures that predicates return exactly one answer and avoid unnecessary backtracking.
- **Implementation**: The cut operator (`!`) is used to prevent backtracking in all predicates.

---

## How to Use

### Prerequisites
- Install a Prolog interpreter (e.g., SWI-Prolog).

### Running the Program
1. Place `league_data.pl` and `Assignment_1.pl` in the same directory.
2. Start the Prolog interpreter:
   ```bash
   swipl
3. Load the Solution File : 
   ```bash
   ?- consult('Assignment_1.pl').
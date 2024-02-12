import 'package:flutter/material.dart';

class Team {
  final String name;
  final int goalsScored;
  final int goalsConceded;
  final int yellowCards;
  final int redCards;
  final int matchesPlayed;

  Team({
    required this.name,
    required this.goalsScored,
    required this.goalsConceded,
    required this.yellowCards,
    required this.redCards,
    required this.matchesPlayed,
  });
}

class TeamComparisonScreen extends StatefulWidget {
  @override
  _TeamComparisonScreenState createState() => _TeamComparisonScreenState();
}

class _TeamComparisonScreenState extends State<TeamComparisonScreen> {
  final List<Team> teams = [
    Team(
      name: "FC Barcelona",
      goalsScored: 70,
      goalsConceded: 30,
      yellowCards: 40,
      redCards: 2,
      matchesPlayed: 38,
    ),
    Team(
      name: "Real Madrid",
      goalsScored: 65,
      goalsConceded: 25,
      yellowCards: 35,
      redCards: 1,
      matchesPlayed: 38,
    ),
    Team(
      name: "Manchester City",
      goalsScored: 80,
      goalsConceded: 20,
      yellowCards: 30,
      redCards: 0,
      matchesPlayed: 38,
    ),
    Team(
      name: "Liverpool",
      goalsScored: 75,
      goalsConceded: 22,
      yellowCards: 28,
      redCards: 1,
      matchesPlayed: 38,
    ),
    Team(
      name: "Bayern Munich",
      goalsScored: 85,
      goalsConceded: 15,
      yellowCards: 25,
      redCards: 0,
      matchesPlayed: 38,
    ),
    Team(
      name: "Paris Saint-Germain",
      goalsScored: 78,
      goalsConceded: 18,
      yellowCards: 32,
      redCards: 2,
      matchesPlayed: 38,
    ),
    Team(
      name: "Manchester United",
      goalsScored: 68,
      goalsConceded: 28,
      yellowCards: 38,
      redCards: 1,
      matchesPlayed: 38,
    ),
    Team(
      name: "Juventus",
      goalsScored: 72,
      goalsConceded: 24,
      yellowCards: 27,
      redCards: 0,
      matchesPlayed: 38,
    ),
    Team(
      name: "AC Milan",
      goalsScored: 66,
      goalsConceded: 26,
      yellowCards: 34,
      redCards: 1,
      matchesPlayed: 38,
    ),
    Team(
      name: "Chelsea",
      goalsScored: 82,
      goalsConceded: 16,
      yellowCards: 29,
      redCards: 0,
      matchesPlayed: 38,
    ),
    // Add more teams and their statistics
  ];

  String? selectedTeam1;
  String? selectedTeam2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                      value: selectedTeam1,
                      onChanged: (String? value) {
                        setState(() {
                          selectedTeam1 = value;
                        });
                      },
                      items: teams.map((Team team) {
                        return DropdownMenuItem<String>(
                          value: team.name,
                          child: Text(team.name),
                        );
                      }).toList(),
                      hint: Text("Team Name"),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      isExpanded: true,
                      underline: Container()),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                      value: selectedTeam2,
                      onChanged: (String? value) {
                        setState(() {
                          selectedTeam2 = value;
                        });
                      },
                      items: teams.map((Team team) {
                        return DropdownMenuItem<String>(
                          value: team.name,
                          child: Text(team.name),
                        );
                      }).toList(),
                      hint: Text("Team Name"),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      isExpanded: true,
                      underline: Container()),
                ),
                SizedBox(height: 20),
                if (selectedTeam1 != null &&
                    selectedTeam2 != null &&
                    selectedTeam1 != selectedTeam2)
                  _displayComparison(selectedTeam1!, selectedTeam2!),
                if (selectedTeam1 == selectedTeam2) Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayComparison(String team1, String team2) {
    Team t1 = teams.firstWhere((t) => t.name == team1);
    Team t2 = teams.firstWhere((t) => t.name == team2);

    return Column(
      children: [
        SizedBox(height: 20),
        _buildComparisonCard(team1, t1),
        SizedBox(height: 20),
        _buildComparisonCard(team2, t2),
      ],
    );
  }

  Widget _buildComparisonCard(String teamName, Team team) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              teamName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            _buildComparisonItem('Goals Scored', team.goalsScored.toString()),
            _buildComparisonItem(
                'Goals Conceded', team.goalsConceded.toString()),
            _buildComparisonItem('Red Cards', team.redCards.toString()),
            _buildComparisonItem(
                'Matches Played', team.matchesPlayed.toString()),
            _buildComparisonItem('Yellow Cards', team.yellowCards.toString()),
            // Add more team performance metrics for comparison
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}

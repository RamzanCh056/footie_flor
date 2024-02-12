import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatsTeam extends StatefulWidget {
  const StatsTeam({Key? key});

  @override
  State<StatsTeam> createState() => _StatsTeamState();
}

class _StatsTeamState extends State<StatsTeam> {
  Map<String, dynamic> stats = {};

  bool isScoreLoading = true;

  Future<void> getStats() async {
    var headers = {
      'X-RapidAPI-Key': '64a0a0da7emsh85e2fd2975d435fp197eb0jsn2bb9bfebada6',
      'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v3/fixtures/statistics?fixture=215662'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);

      setState(() {
        stats = body;
        print('stats= $stats');
        isScoreLoading = false;
      });

      if (stats.isEmpty) {
        print('No data found.');
      }
    } else {
      print(response.reasonPhrase);
      setState(() {
        isScoreLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          isScoreLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: 2, // Since only one league is expected
                    itemBuilder: (context, index) {
                      if (stats == null) {
                        return Container(
                          child: Text('no data found'),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 22.0, right: 22, top: 12, bottom: 5),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            stats['response'][index]['team']
                                                ['name'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Image.network(
                                          stats['response'][index]['team']
                                              ['logo'],
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Statistics',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          stats['response'][index]['statistics']
                                              [index]['type'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

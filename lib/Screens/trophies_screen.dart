import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Trophy extends StatefulWidget {
  const Trophy({Key? key});

  @override
  State<Trophy> createState() => _TrophyState();
}

class _TrophyState extends State<Trophy> {
  Map<String, dynamic> trophy = {};

  bool isScoreLoading = true;

  Future<void> getTrophy() async {
    var headers = {
      'X-RapidAPI-Key': '64a0a0da7emsh85e2fd2975d435fp197eb0jsn2bb9bfebada6',
      'X-RapidAPI-Host': 'api-football-v1.p.rapidapi.com'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api-football-v1.p.rapidapi.com/v3/trophies?player=276'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      var body = jsonDecode(res);

      setState(() {
        trophy = body;
        print('trophy= $trophy');
        isScoreLoading = false;
      });

      if (trophy.isEmpty) {
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
    getTrophy();
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
                    itemCount: 45, // Since only one league is expected
                    itemBuilder: (context, index) {
                      if (trophy == null) {
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
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          trophy['response'][index]['league'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
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
                                            'Country',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          trophy['response'][index]['country'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
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
                                            'Season',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          trophy['response'][index]['season'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
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
                                            'Place',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          trophy['response'][index]['place'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
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

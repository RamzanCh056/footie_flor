import 'package:flutter/material.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:footie_follower_zone/Screens/standing.dart';
import 'package:footie_follower_zone/Screens/stats_screen.dart';
import 'package:footie_follower_zone/Screens/teams_comparison.dart';
import 'package:footie_follower_zone/Screens/trophies_screen.dart';

class MyTabbedPage extends StatefulWidget {
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    final selectedTextStyle = textStyle?.copyWith(fontWeight: FontWeight.bold);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SegmentedTabControl(
                  // Customization of widget
                  radius: const Radius.circular(22),
                  backgroundColor: Colors.black26,
                  indicatorColor: Colors.black45,
                  tabTextColor: Colors.black45,
                  selectedTabTextColor: Colors.white,
                  squeezeIntensity: 2,
                  height: 45,
                  tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: textStyle,
                  selectedTextStyle: selectedTextStyle,

                  tabs: [
                    SegmentTab(
                      label: 'STANDINGS',
                      color: Colors.black38,
                    ),
                    SegmentTab(
                      label: 'COMPARISON',
                      backgroundColor: Colors.black12,
                      selectedTextColor: Colors.white,
                      color: Colors.black45,
                    ),
                    SegmentTab(
                      label: 'STATS',
                      color: Colors.black38,
                    ),
                    SegmentTab(
                      label: 'TROPHY',
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              // Sample pages
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Standings(),
                    TeamComparisonScreen(),
                    StatsTeam(),
                    Trophy()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

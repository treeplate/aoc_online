import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'day1.dart';
import 'day2.dart';
import 'day3.dart';
import 'day4.dart';
import 'day5.dart';
import 'day6.dart';
import 'day7.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @Preview()
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(
    length: 7,
    vsync: this,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Day 1'),
            Tab(text: 'Day 2'),
            Tab(text: 'Day 3'),
            Tab(text: 'Day 4'),
            Tab(text: 'Day 5'),
            Tab(text: 'Day 6'),
            Tab(text: 'Day 7'),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [Day1(), Day2(), Day3(), Day4(), Day5(), Day6(), Day7()],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

void main() {
  runApp(App());
  main();
}

class App extends StatefulWidget {
  @Preview()
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  TextEditingController controller = TextEditingController();
  TextEditingController c2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: TabBar(
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
          //children: [Day1(), Day2(), Day3(), Day4(), Day5(), Day6(), Day7()],
        ),
      ),
    );
  }
}

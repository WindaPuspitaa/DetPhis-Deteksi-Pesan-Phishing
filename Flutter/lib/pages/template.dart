import 'package:flutter/material.dart';

import 'home.dart';
import 'detect.dart';
import 'history.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  late int index;

  List showWidget = [
    HomePage(),
    DetectPage(),
    HistoryPage(),
  ];

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: showWidget[index],
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.blue,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Detect"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "History"),
          ],
        ),
      ),
    );
  }
}

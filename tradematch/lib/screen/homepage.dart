import 'package:flutter/material.dart';
import 'package:tradematch/themes/themes.dart';
import 'package:tradematch/widget/widgets.dart' as widgets;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: forestBackground),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(164, 222, 255, 195),
          ),
          widgets.CustomDrawer(),
        ],
      ),
    );
  }
}

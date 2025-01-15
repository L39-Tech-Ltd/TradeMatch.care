import 'package:flutter/material.dart';
import 'package:tradematch/themes/themes.dart';
import 'package:tradematch/widget/widgets.dart' as widgets;

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: forestBackground),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color.fromARGB(163, 254, 255, 195),
          ),
          widgets.CustomDrawer(),
        ],
      ),
    );
  }
}

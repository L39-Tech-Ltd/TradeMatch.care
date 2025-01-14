import 'package:flutter/material.dart';
import 'route.dart';

void main() {
  runApp(const TradeMatch());
}

class TradeMatch extends StatelessWidget {
  const TradeMatch({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

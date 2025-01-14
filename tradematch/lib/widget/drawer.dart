import 'package:flutter/material.dart';
import 'package:tradematch/themes/themes.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final double _drawerHeightOffset = 200;
  final int drawerAnimation = 300;

  final double lineMax = 100;
  final double lineMin = 0;
  final double lineHeight = 2;
  final int lineAnimation = 300;

  final List<double> menuIconPosition = [10, 10, 0, 0];
  final double menuIconSize = 30;

  final List<double> drawerPosition = [60, 10, 0, 0];

  final double drawerSideLineWidth = 5;
  final double drawerSideLineOffset = 20;

  final List<double> itemMargin = [20, 0];
  final double itemSpacing = 10;

  double drawerWidth = 0;
  double padding = 200;

  final double itemFontSize = 20;

  // Menu items
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.home, 'text': 'HOME', 'route': '/home'},
    {'icon': Icons.settings, 'text': 'SETTINGS', 'route': '/settings'},
    {'icon': Icons.person, 'text': 'PROFILE', 'route': '/profile'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: drawerAnimation),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleDrawer() {
    if (_animationController.isDismissed) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Widget customHoverTile(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    double lineWidth = 0;

    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          onTap: onTap,
          onHover: (hovering) {
            setState(() {
              lineWidth = hovering ? lineMax : lineMin;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: itemMargin[0]),
            child: Row(
              spacing: itemSpacing,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: lineAnimation),
                  width: lineWidth,
                  height: lineHeight,
                  color: drawerLineColor,
                ),
                Icon(icon, color: drawerTileItemColor),
                Text(
                  text,
                  style: TextStyle(
                    color: drawerTileItemColor,
                    fontSize: itemFontSize,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double getTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: menuIconPosition[0],
          left: menuIconPosition[1],
          child: IconButton(
            onPressed: toggleDrawer,
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _animationController,
              size: menuIconSize,
              color: drawerIconColor,
            ),
          ),
        ),
        SlideTransition(
          position: _slideAnimation,
          child: LayoutBuilder(
            builder: (context, constraints) {
              for (var item in _menuItems) {
                double itemWidth = getTextWidth(
                  item['text'],
                  TextStyle(fontSize: itemFontSize),
                );
                drawerWidth = drawerWidth > itemWidth ? drawerWidth : itemWidth;
              }

              return Container(
                margin: EdgeInsets.only(
                  top: drawerPosition[0],
                  left: drawerPosition[1],
                ),
                width:
                    drawerWidth +
                    padding +
                    drawerSideLineOffset +
                    drawerPosition[1],
                height:
                    MediaQuery.of(context).size.height - _drawerHeightOffset,
                child: Row(
                  children: [
                    Container(
                      width: drawerSideLineWidth,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(right: drawerSideLineOffset),
                      color: drawerSideLine,
                    ),
                    Container(
                      width: drawerWidth + padding,
                      color: drawerBackgroundColor,
                      child: Column(
                        children:
                            _menuItems.map((item) {
                              return customHoverTile(
                                context,
                                icon: item['icon'],
                                text: item['text'],
                                onTap: () {
                                  context.go(item['route']);
                                },
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tradematch/themes/themes.dart';

class CustomScrollWidget extends StatefulWidget {
  final List<Widget> sections;

  const CustomScrollWidget({super.key, required this.sections});

  @override
  State<CustomScrollWidget> createState() => _CustomScrollWidgetState();
}

class _CustomScrollWidgetState extends State<CustomScrollWidget> {
  // 🔧 Number Variables
  final int scrollAnimationDuration = 500; // Duration for page scroll animation
  final double iconButtonSize = 40; // Size of the up/down arrow buttons
  final double numberCarouselHeight = 100; // Height of the number carousel
  final double numberCarouselWidth = 60; // Width of the number carousel
  final double viewportFraction =
      0.4; // Fraction of the viewport to show previews
  final double carouselCircularBorder = 0;
  final double pageNumberFontSize = 30;
  final double scrollSpacing = 10;

  // 🔧 Controllers
  final PageController _pageController = PageController();
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  // 🔧 Current Page Tracking
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onScroll(PointerScrollEvent event) {
    if (event.scrollDelta.dy > 0) {
      nextPage();
    } else if (event.scrollDelta.dy < 0) {
      previousPage();
    }
  }

  void nextPage() {
    if (_currentPage < widget.sections.length - 1) {
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: scrollAnimationDuration),
        curve: Curves.easeInOut,
      );
      _carouselController.animateToPage(_currentPage);
    }
  }

  void previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: scrollAnimationDuration),
        curve: Curves.easeInOut,
      );
      _carouselController.animateToPage(_currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // PageView
        Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              onScroll(event);
            }
          },
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: widget.sections,
          ),
        ),

        // Control Buttons with Number Carousel
        Positioned(
          top:
              MediaQuery.of(context).size.height / 2 - numberCarouselHeight / 2,
          right: 20,
          child: Container(
            color: drawerBackgroundColor,
            child: Column(
              spacing: scrollSpacing,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Up Button
                IconButton(
                  onPressed: previousPage,
                  icon: const Icon(Icons.arrow_upward, color: Colors.white),
                  tooltip: 'Scroll Up',
                  iconSize: iconButtonSize,
                ),

                // Number Carousel
                Container(
                  height: numberCarouselHeight,
                  width: numberCarouselWidth,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(143, 213, 255, 134),
                    borderRadius: BorderRadius.circular(carouselCircularBorder),
                  ),
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: widget.sections.length,
                    itemBuilder: (context, index, realIndex) {
                      return Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: pageNumberFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: numberCarouselHeight,
                      enlargeCenterPage: true,
                      viewportFraction: viewportFraction,
                      initialPage: _currentPage,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.vertical,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),

                // Down Button
                IconButton(
                  onPressed: nextPage,
                  icon: const Icon(Icons.arrow_downward, color: Colors.white),
                  tooltip: 'Scroll Down',
                  iconSize: iconButtonSize,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

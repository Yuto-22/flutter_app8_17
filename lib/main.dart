import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body:Introduction(),
      ),
    );
  }
}



class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}


class _IntroductionState extends State<Introduction> {

  final PageController controller = PageController(viewportFraction: 0.8);
  final _currentPageNotifier = ValueNotifier<int>(0);

  int currentPage = 0;
  final List<String> _imageList = [
    "assets/image01.png",
    "assets/image02.jpg"
  ];


  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      int next = controller.page!.round();
      if (_currentPageNotifier != next) {
        setState(() {
          _currentPageNotifier.value = next;
        });
      }
    });
  }

  AnimatedContainer _createCardAnimate(String imagePath, bool active) {
    final double top = active ? 100 : 200;
    final double side = active ? 0 : 40;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50.0, right: side, left: side),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: Image
              .asset(imagePath)
              .image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[

          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: _imageList.length,
              itemBuilder: (context, int currentIndex){
                bool active = currentIndex == currentPage;
                return _createCardAnimate(
                  _imageList[currentIndex],
                  active,
                );
              },
            ),
          ),
          Container(
            height: 30,
            child: CirclePageIndicator(
              itemCount: _imageList.length,
              currentPageNotifier: _currentPageNotifier,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Pay'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,

                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add to bag'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
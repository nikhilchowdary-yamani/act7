import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  bool _isDarkMode = false;
  bool _showFrame = true;
  Color _textColor = Colors.grey;
  int _currentPage = 0;
  final PageController _pageController = PageController();

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void toggleFrame() {
    setState(() {
      _showFrame = !_showFrame;
    });
  }

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (Color color) {
                setState(() {
                  _textColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text Animation'),
        backgroundColor: _isDarkMode ? Colors.grey : Colors.blue,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleTheme,
            tooltip: 'Toggle theme',
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: _openColorPicker,
            tooltip: 'Change text color',
          ),
        ],
      ),
      body: Container(
        color: _isDarkMode ? Colors.grey[850] : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    _isVisible = true;
                  });
                },
                children: [
                  Center(
                    child: AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: Duration(seconds: 3),
                      child: Text(
                        'Hello, Flutter!',
                        style: TextStyle(
                          fontSize: 24,
                          color: _textColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      child: Text(
                        'Swipe Animation!',
                        style: TextStyle(
                          fontSize: 24,
                          color: _textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: _showFrame
                  ? BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 4),
                      borderRadius: BorderRadius.circular(15),
                    )
                  : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'https://pe-images.s3.amazonaws.com/basics/cc/image-size-resolution/resize-images-for-print/image-cropped-8x10.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: SwitchListTile(
                title: Text('Toggle Frame'),
                value: _showFrame,
                onChanged: (value) {
                  toggleFrame();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        backgroundColor: _isDarkMode ? Colors.tealAccent : Colors.blue,
        child: Icon(Icons.play_arrow),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
            _isVisible = true;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.animation),
            label: 'Animation 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.animation_outlined),
            label: 'Animation 2',
          ),
        ],
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
        selectedItemColor: _isDarkMode ? Colors.tealAccent : Colors.blue,
        unselectedItemColor: _isDarkMode ? Colors.grey : Colors.grey[600],
      ),
    );
  }
}

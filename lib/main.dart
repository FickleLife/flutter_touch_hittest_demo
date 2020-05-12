import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyBoard(),
    );
  }
}

class NewButton extends StatefulWidget {
  NewButton(Key key) : super(key: key);
  @override
  NewButtonState createState() => NewButtonState();
}

class NewButtonState extends State<NewButton> {
  bool isCurrentlyTouching = false;

  void handleTouch(bool isTouching) {
    setState(() {
      isCurrentlyTouching = isTouching;
      print('touch');
    });
    // some other functionality on touch
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 40.0,
      color: isCurrentlyTouching ? Colors.red : Colors.white,
    );
  }
}



class MyBoard extends StatefulWidget {
  static final keys = List<GlobalKey>.generate(3, (ndx) => GlobalKey());

  @override
  _MyBoardState createState() => _MyBoardState();
}

class _MyBoardState extends State<MyBoard> {
  NewButton getTouchingButton(Offset globalPosition) {
    NewButton currentButton;
    // result is outside of [isTouchingMyButtonKey] for performance
    final result = BoxHitTestResult();
    print(result);

    bool isTouchingButtonKey(GlobalKey key) {
      RenderBox renderBox = key.currentContext.findRenderObject();
      Offset offset = renderBox.globalToLocal(globalPosition);
      print(offset);
      return renderBox.hitTest(result, position: offset);
    }

    var key = MyBoard.keys.firstWhere(isTouchingButtonKey, orElse: () => null);
    if (key != null) currentButton = key.currentWidget;

    return currentButton;
  }

  /// I control the number of buttons by the number of keys,
  /// since all the buttons should have a key
  List<Widget> makeButtons() {
    return MyBoard.keys.map((key) {
      // preapre some funcitonality here
      return NewButton(key);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: 300.0,
      height: 600.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: makeButtons(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _textController = TextEditingController();
  bool isTextEntered = false;
  String enteredText = '';

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        isTextEntered = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void handleButtonPress(bool SendTextOrNot) {
    if (SendTextOrNot) {
      setState(() {
        enteredText = _textController.text;
      });
    } else {
      setState(() {
        enteredText = '';
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecondPage(
          enteredText: enteredText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                handleButtonPress(false);
              },
              child: Text('Gå till nästa sida'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Ange något här',
                ),
                onEditingComplete: () {
                  handleButtonPress(true);
                },
              ),
            ),
            Visibility(
              visible: isTextEntered,
              child: TextButton(
                onPressed: () {
                  handleButtonPress(true);
                },
                child: Text('Skicka till nästa sida'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String enteredText;

  SecondPage({required this.enteredText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Andra Sida'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Det här är den andra sidan!'),
            SizedBox(height: 20),
            Text('$enteredText'),
            SizedBox(height: 20),
            Image.network(
              'https://cdn.pixabay.com/photo/2023/08/14/20/04/bee-8190665_640.jpg',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

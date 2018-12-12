import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mmkv/flutter_mmkv.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _rootDir = 'Unknown';
  String _mystring;
  final _myController = TextEditingController();
  final String _keyString = "mystring";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String rootDir;
    String mystring;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // rootDir = await FlutterMmkv.getRootDir();
      // mystring = await FlutterMmkv.decodeString(_keyString);
    } on PlatformException {
      rootDir = 'Failed to get';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _rootDir = rootDir;
      _mystring = mystring;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FlutterMMKV Plugin'),
        ),
        body: Column(
          children: [
            Column(
              children: <Widget>[
                Text('Root Directory : $_rootDir\n'),
                Text('Decoded value key=$_keyString :$_mystring'),
                TextField(
                  controller: _myController,
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          FlutterMmkv.encodeString(
                              _keyString, _myController.text.toString());
                        },
                        child: Text(
                          'Encode',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          FlutterMmkv.decodeString(_keyString).then((value) {
                            this.setState(() {
                              _mystring = value;
                            });
                          });
                        },
                        child: Text(
                          'Decode',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          this.setState(() {
                            _mystring = null;
                          });
                        },
                        child: Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          FlutterMmkv.removeAll().then((value) {
                            FlutterMmkv.decodeString(_keyString).then((value) {
                              this.setState(() {
                                _mystring = value;
                              });
                            });
                          });
                        },
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text("Encode: Store value to cache"),
                Text("Decode: Decode value from cache"),
                Text("Clear: Clear decoded value(not deleting cache)"),
                Text("Remove: Delete cache"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
  String _myString1;
  String _myString2;
  final _myController = TextEditingController();
  final String _keyString1 = "string1";
  final String _keyString2 = "string2";

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
      rootDir = await FlutterMmkv.getRootDir();
      mystring = await FlutterMmkv.decodeString(_keyString1);
      await FlutterMmkv.encodeBool("bool", true);
      // bool a = await FlutterMmkv.decodeBool("bool");
      // print(a.toString());
    } on PlatformException {
      rootDir = 'Failed to get';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _rootDir = rootDir;
      _myString1 = mystring;
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
                Text('Decoded value key=$_keyString1 :$_myString1'),
                Text('Decoded value key=$_keyString2 :$_myString2'),
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
                              _keyString1, _myController.text.toString());
                        },
                        child: Text(
                          'Encode1',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          FlutterMmkv.decodeString(_keyString1).then((value) {
                            this.setState(() {
                              _myString1 = value;
                            });
                          });
                        },
                        child: Text(
                          'Decode1',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          this.setState(() {
                            _myString1 = null;
                          });
                        },
                        child: Text(
                          'Clear1',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          FlutterMmkv.removeValueForKey(_keyString1)
                              .then((value) {
                            FlutterMmkv.decodeString(_keyString1).then((value) {
                              this.setState(() {
                                _myString1 = value;
                              });
                            });
                          });
                        },
                        child: Text(
                          'Remove1',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          FlutterMmkv.encodeString(
                              _keyString2, _myController.text.toString());
                        },
                        child: Text(
                          'Encode2',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          FlutterMmkv.decodeString(_keyString2).then((value) {
                            this.setState(() {
                              _myString2 = value;
                            });
                          });
                        },
                        child: Text(
                          'Decode2',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          this.setState(() {
                            _myString2 = null;
                          });
                        },
                        child: Text(
                          'Clear2',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          FlutterMmkv.removeValueForKey(_keyString2)
                              .then((value) {
                            FlutterMmkv.decodeString(_keyString2).then((value) {
                              this.setState(() {
                                _myString2 = value;
                              });
                            });
                          });
                        },
                        child: Text(
                          'Remove2',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ButtonTheme.bar(
                  child: RaisedButton(
                    onPressed: () {
                      FlutterMmkv.removeAll().then((value) {
                        FlutterMmkv.decodeString(_keyString1).then((value) {
                          this.setState(() {
                            _myString1 = value;
                          });
                        });
                        FlutterMmkv.decodeString(_keyString2).then((value) {
                          this.setState(() {
                            _myString2 = value;
                          });
                        });
                      });
                    },
                    child: Text(
                      'RemoveAll',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text("Encode<N>: Store value to cache N"),
                Text("Decode<N>: Decode value from cache N"),
                Text("Clear<N>: Clear decoded value N (not deleting cache)"),
                Text("Remove<N>: Delete cache N"),
                Text("RemoveAll: Delete all cache"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

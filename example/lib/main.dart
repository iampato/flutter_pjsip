import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pjsip/flutter_pjsip.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sip_native/sip_native.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _calltateText = '';
  FlutterPjsip _pjsip;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initSipPlugin();
  }

  void initSipPlugin() {
    _pjsip = FlutterPjsip();
    _pjsip.onSipStateChanged.listen((map) {
      final state = map['call_state'];
      final remoteUri = map['remote_uri'];
      print('state: $state');
      switch (state) {
        case "CALLING":
          break;

        case "INCOMING":
          break;

        case "EARLY":
          break;

        case "CONNECTING":
          break;

        case "CONFIRMED":
          break;

        case "DISCONNECTED":
          break;

        default:
          break;
      }

      setState(() {
        this._calltateText = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('SIP connection: $isConnected'),
            Text('Call state: $_calltateText'),
            Spacer(),
            Wrap(
              runSpacing: 5,
              spacing: 15,
              children: <Widget>[
                RaisedButton(
                  child: Text('Sip Permissions'),
                  onPressed: () async {
                    bool res = await SipNative.requestPermissions();
                    showToast('Permissions', res);
                  },
                ),
                RaisedButton(
                  child: Text('Sip init'),
                  onPressed: () => _sipInit(),
                ),
                RaisedButton(
                  child: Text('Sip login'),
                  onPressed: () => _sipLogin(),
                ),
                RaisedButton(
                  child: Text('Sip call'),
                  onPressed: () => _sipCall(),
                ),
                RaisedButton(
                  child: Text('Sip logout'),
                  onPressed: () => _sipLogout(),
                ),
                RaisedButton(
                  child: Text('Sip de-init'),
                  onPressed: () => _sipDeinit(),
                ),
                RaisedButton(
                  child: Text('Sip receive'),
                  onPressed: () => _sipReceive(),
                ),
                RaisedButton(
                  child: Text('Sip Refure'),
                  onPressed: () => _sipRefuse(),
                ),
                RaisedButton(
                  child: Text('Sip handfree'),
                  onPressed: () => _sipHandsFree(),
                ),
                RaisedButton(
                  child: Text('Sip mute'),
                  onPressed: () => _sipMute(),
                ),
                RaisedButton(
                  child: Text('Sip dispose'),
                  onPressed: () => _sipDispose(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sipInit() async {
        bool initSuccess = await _pjsip.pjsipInit();
    showToast('_sipInit', initSuccess);
  }

  Future<void> _sipLogin() async {
    bool loginSuccess = await _pjsip.pjsipLogin(
      username: '254717008247',
      password: '475bbd248835981240e0fab16cdeb5af',
      ip: "138.68.167.56",
      port: "5060",
    );
    setState(() {
      isConnected = true;
    });
    showToast('_sipLogin', loginSuccess);
  }

  Future<void> _sipCall() async {
    bool callSuccess = await _pjsip.pjsipCall(
      username: '254730303105',
      ip: "138.68.167.56",
      port: '5060',
    );
    
    showToast('_sipCall', callSuccess);
  }

  Future<void> _sipLogout() async {
    bool logoutSuccess = await _pjsip.pjsipLogout();
    showToast('_sipLogout', logoutSuccess);
  }

  Future<void> _sipDeinit() async {
    bool initSuccess = await _pjsip.pjsipDeinit();
    showToast('_sipDeinit', initSuccess);
  }

  Future<void> _sipReceive() async {
    bool receiveSuccess = await _pjsip.pjsipReceive();
    showToast('_sipReceive', receiveSuccess);
  }

  Future<void> _sipRefuse() async {
    bool refuseSuccess = await _pjsip.pjsipRefuse();
    showToast('_sipRefuse', refuseSuccess);
  }

  Future<void> _sipHandsFree() async {
    bool handsFreeSuccess = await _pjsip.pjsipHandsFree();
    showToast('_sipHandsFree', handsFreeSuccess);
  }

  Future<void> _sipMute() async {
    bool muteSuccess = await _pjsip.pjsipMute();
    showToast('_sipMute', muteSuccess);
  }

  Future<void> _sipDispose() async {
    await _pjsip.dispose();
    showToast('_sipDispose', true);
  }

  void showToast(String method, bool success) {
    String successText = success ? 'Success' : 'Failure';
    Fluttertoast.showToast(msg: '$method $successText');
  }
}

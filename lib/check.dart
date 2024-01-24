import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_home_app/access/door.dart';
import 'package:smart_home_app/access/gate.dart';
import 'package:smart_home_app/lights/dining.dart';
import 'package:smart_home_app/lights/toilet.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isButtonClicked = false;
  bool isButtonClick = false;
  bool isParlor = false;
  bool isKitchen = false;
  bool isToilet = false;
  bool isPerimeter = false;

  final String esp32IpAddress =
      '192.168.4.1'; //Replace with your ESP32 IP address
  bool isPirActivated = false;

  Future<void> _sendCommand(String command) async {
    if (isButtonClicked) {
      final response =
          await http.get(Uri.parse('http://$esp32IpAddress/$command'));

      if (response.statusCode == 200) {
        print('Command $command sent successfully');
      } else {
        print(
            'Failed to send command $command. Status code: ${response.statusCode}');
      }
    } else {
      print('Person icon not clicked, command not sent.');
    }
  }

  @override
  void initState() {
    super.initState();
    // Check PIR status periodically
    Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      int pirStatus = await _checkPIRStatus();
      setState(() {
        isPirActivated = (pirStatus == 1);
      });
    });
  }

  Future<int> _checkPIRStatus() async {
    final response = await http.get(Uri.parse('http://$esp32IpAddress/8'));
    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      print('Failed to get PIR status. Status code: ${response.statusCode}');
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(28, 54, 28, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.person_2,
                    size: 24,
                    color: isPirActivated ? Colors.red : Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      isButtonClicked = !isButtonClicked;
                    });
                    _sendCommand('8'); //Toggle PIR sensor
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Rest of your code...
          ],
        ),
      ),
    );
  }
}

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
  bool isBedroom = false;
  bool isPerimeter = false;

  final String esp32IpAddress = '192.168.4.1';

  //Replace with your ESP32 IP address
  bool isPirActivated = false;

  Future<void> _sendCommand(String command) async {
    final response =
        await http.get(Uri.parse('http://$esp32IpAddress/$command'));
 
    if (response.statusCode == 200) {
      print('Command $command sent successfully');
    } else {
      print(
          'Failed to send command $command. Status code: ${response.statusCode}');
    }
  }

  Future<void> _checkPIRStatus() async {
    // Fetch the PIR status from ESP32
    final response = await http.get(Uri.parse('http://$esp32IpAddress/8'));
    if (response.statusCode == 200) {
      int pirStatus = int.parse(response.body);
      setState(() {
        isPirActivated = (pirStatus == 1);
      });
    } else {
      print('Failed to get PIR status. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();

    ///Periodically check PIR status
    Timer.periodic(Duration(seconds: 5), (timer) {
      _checkPIRStatus();
    });
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
                MaterialButton(
                    child: Container(
                      height: 21,
                      width: 21,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isPirActivated ? Colors.red : Colors.green,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _checkPIRStatus();
                      });
                    }),
              ],
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Access",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF575757),
                ),
              ),
            ),
            const SizedBox(height: 9),
            Container(
              width: 355,
              height: 144,
              decoration: const BoxDecoration(
                color: Color(0XFF012C58),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/gate.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Gate",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          isButtonClick = !isButtonClick;
                          isButtonClick ? _sendCommand('D') : _sendCommand('E');
                          isButtonClick ? _sendCommand('B') : _sendCommand('C');
                        });
                      },
                      child:
                          isButtonClick ? const GateClose() : const GateOpen(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 17),
            Container(
              width: 355,
              height: 144,
              decoration: const BoxDecoration(
                color: Color(0XFF0372E4),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/door.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Door",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          isButtonClicked = !isButtonClicked;
                          isButtonClicked
                              ? _sendCommand('9')
                              : _sendCommand('A');
                        });
                      },
                      child: isButtonClicked
                          ? const DoorClose()
                          : const DoorOpen(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 34),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Light",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF575757),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 172,
                  height: 164,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEFF0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/dining.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          "Parlor",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF012F5E),
                          ),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isParlor = !isParlor;
                              isParlor ? _sendCommand('0') : _sendCommand('1');
                            });
                          },
                          child: isParlor ? const RedOff() : const RedOn(),

                          ///child: ? RedOn() : RedOff(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                Container(
                  width: 172,
                  height: 164,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE3F3FF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/kitchen.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          "Kitchen",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF012F5E),
                          ),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              isKitchen = !isKitchen;
                              isKitchen ? _sendCommand('2') : _sendCommand('3');
                            });
                          },
                          child: isKitchen ? const BlueOff() : const BlueOn(),

                          ///child: ? BlueOn() : BlueOff(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                Container(
                  width: 172,
                  height: 164,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE3F3FF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/bedroom.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          "Bedroom",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF012F5E),
                          ),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              isBedroom = !isBedroom;
                              isBedroom ? _sendCommand('4') : _sendCommand('5');
                            });
                          },
                          child: isBedroom ? const BlueOff() : const BlueOn(),

                          ///child: ? BlueOn() : BlueOff(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                Container(
                  width: 172,
                  height: 164,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEFF0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/perimeter.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        const Text(
                          "Perimeter",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF012F5E),
                          ),
                        ),
                        const SizedBox(height: 30),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              isPerimeter = !isPerimeter;
                              isPerimeter
                                  ? _sendCommand('6')
                                  : _sendCommand('7');
                            });
                          },
                          child: isPerimeter ? const RedOff() : const RedOn(),

                          ///child: ? RedOn() : RedOff(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

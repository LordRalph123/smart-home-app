import 'package:flutter/material.dart';
import 'package:smart_home_app/access/door.dart';
import 'package:smart_home_app/access/gate.dart';
import 'package:smart_home_app/lights/dining.dart';
import 'package:smart_home_app/lights/toilet.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';


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

final blue = FlutterBluePlus.instance;
  BluetoothDevice? targetDevice;

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  void _connectToDevice() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (result.device.name == 'Your Arduino Bluetooth Name') {
          targetDevice = result.device;
          break;
        }
      }
    });

    FlutterBluePlus.stopScan();

    if (targetDevice != null) {
      await targetDevice!.connect();
    }
  }

  Future<void> _sendCommand(String command) async {
    if (targetDevice != null) {
      List<BluetoothService> services = await targetDevice!.discoverServices();
      for (BluetoothService service in services) {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        for (BluetoothCharacteristic characteristic in characteristics) {
          if (characteristic.properties.write) {
            await characteristic.write([command.codeUnitAt(0)]);
            return;
          }
        }
      }
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person_2,
                    size: 24,
                    color: Colors.lightBlue,
                  ),
                ),
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
                        });
                      },
                      child: isButtonClicked
                          ? const DoorOpen()
                          : const DoorClose(),
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
                        });
                      },
                      child:
                          isButtonClick ? const GateOpen() : const GateClose(),
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
                            });
                          },
                          child: isParlor ? const RedOn() : const RedOff(),
                          //child: ? RedOn() : RedOff(),
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
                            });
                          },
                          child: isKitchen ? const BlueOn() : const BlueOff(),
                          //child: ? BlueOn() : BlueOff(),
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
                              isToilet = !isToilet;
                            });
                          },
                          child: isToilet ? const BlueOn() : const BlueOff(),
                          //child: ? BlueOn() : BlueOff(),
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
                            });
                          },
                          child: isPerimeter ? const RedOn() : const RedOff(),
                          //child: ? RedOn() : RedOff(),
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

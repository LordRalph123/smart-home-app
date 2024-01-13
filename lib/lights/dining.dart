import 'package:flutter/material.dart';

class BlueOn extends StatelessWidget {
  const BlueOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 63,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0XFFBBE2FF),
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        border: Border.all(
          color: const Color(0XFF93D1FF),
          width: 1.0,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 4),
            Text(
              "Off",
              style: TextStyle(
                fontSize: 14,
                color: Color(0XFF56B7FF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlueOff extends StatelessWidget {
  const BlueOff({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 63,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0XFFBBE2FF),
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        border: Border.all(
          color: const Color(0XFF93D1FF),
          width: 1.0,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "On",
              style: TextStyle(
                fontSize: 14,
                color: Color(0XFF56B7FF),
              ),
            ),
            SizedBox(width: 6),
            CircleAvatar(
              radius: 12,
              backgroundColor: Color(0XFF005CA1),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RedOn extends StatelessWidget {
  const RedOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 63,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0XFFFFBABE),
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        border: Border.all(
          color: const Color(0XFFFF8E94),
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
            SizedBox(width: 5),
            Text(
              "Off",
              style: TextStyle(
                fontSize: 14,
                color: Color(0XFFFF8E94),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RedOff extends StatelessWidget {
  const RedOff({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 63,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0XFFFFBABE),
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        border: Border.all(
          color:const Color(0XFFFF8E94),
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
                fontSize: 11,
                color: Color(0XFFFF8E94),
              ),
            ),
            SizedBox(width: 5),
            CircleAvatar(
              radius: 12,
              backgroundColor: Color(0XFFFF3642),
            ),
          ],
        ),
      ),
    );
  }
}

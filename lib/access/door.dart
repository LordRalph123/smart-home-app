import 'package:flutter/material.dart';

class DoorOpen extends StatelessWidget {
  const DoorOpen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 281,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF0E86FE),
        borderRadius: const BorderRadius.all(
          Radius.circular(32),
        ),
        border: Border.all(color: const Color(0xFF399BFD), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.lock,
                  color: Color(0xFF024F9D),
                ),
              ),
            ),
           const SizedBox(width: 72),
            const Text(
              "Open",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/opened.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoorClose extends StatelessWidget {
  const DoorClose({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 281,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF0E86FE),
        borderRadius: const BorderRadius.all(
          Radius.circular(32),
        ),
        border: Border.all(color: const Color(0xFF399BFD), 
        width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 100),
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/closed.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "Close",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 64),
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Center(
                child: Icon(
                  Icons.lock_open,
                  color: Color(0xFF024F9D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

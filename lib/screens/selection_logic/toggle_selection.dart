import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleSelection extends StatefulWidget {
  const ToggleSelection({super.key});

  @override
  State<ToggleSelection> createState() => _ToggleSelectionState();
}

class _ToggleSelectionState extends State<ToggleSelection> {
  bool isFollow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7), // Background محسّن

      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 140),

            // --------------------------------------------------------
            // PROFILE IMAGE + FOLLOW BUTTON (Floating)
            // --------------------------------------------------------
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Profile Image with Glow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.25),
                        blurRadius: 28,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 140,
                    backgroundImage: AssetImage(
                      "assets/e4e50cb3ed73e6df3dbb664c72ebaf00.jpg",
                    ),
                  ),
                ),

                // Floating Follow Button
                Positioned(
                  bottom: -18,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => setState(() => isFollow = !isFollow),

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,

                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFollow ? Colors.green : Colors.pinkAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Icon(
                        isFollow
                            ? CupertinoIcons.check_mark
                            : CupertinoIcons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 110),

            // --------------------------------------------------------
            // FOLLOW STATUS CARD
            // --------------------------------------------------------
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: isFollow ? Colors.green : Colors.black87,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isFollow ? CupertinoIcons.check_mark : CupertinoIcons.add,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),

                  Text(
                    "Super Mans",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

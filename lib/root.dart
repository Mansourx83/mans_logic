import 'package:flutter/material.dart';
import 'package:mans_logic/screens/selection_logic/image_selection.dart';
import 'package:mans_logic/screens/selection_logic/multi_selection.dart';
import 'package:mans_logic/screens/selection_logic/single_selection.dart';
import 'package:mans_logic/screens/selection_logic/toggle_selection.dart';
import 'package:mans_logic/screens/Attachments_Images_logic/upload_file.dart';
import 'package:mans_logic/screens/Attachments_Images_logic/upload_image.dart';
import 'package:mans_logic/screens/Attachments_Images_logic/upload_multi_imgs.dart';
import 'package:mans_logic/screens/Attachments_Images_logic/upload_video.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedIndex = 0;

  final PageController controller = PageController();

  final List<Widget> screens = const [
    //logic selection
    SingleSelection(),
    ImageSelection(),
    ToggleSelection(),
    MultiSelection(),

    //logic deal with image and videos,file
    UploadImage(),
    UploadMultiImgs(),
    UploadFile(),
    UploadVideo(),
  ];

  void goToPage(int index) {
    if (index < 0 || index >= screens.length) return;
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() => selectedIndex = value);
        },
        children: screens,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// BACK BUTTON
            ElevatedButton(
              onPressed: selectedIndex > 0
                  ? () => goToPage(selectedIndex - 1)
                  : null,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(width: 6),
                  Text("Back", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),

            /// NEXT BUTTON
            ElevatedButton(
              onPressed: selectedIndex < screens.length - 1
                  ? () => goToPage(selectedIndex + 1)
                  : null,
              style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Row(
                children: [
                  Text("Next", style: TextStyle(fontWeight: FontWeight.w700)),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

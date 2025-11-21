import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadMultiImgs extends StatefulWidget {
  const UploadMultiImgs({super.key});

  @override
  State<UploadMultiImgs> createState() => _UploadMultiImgsState();
}

class _UploadMultiImgsState extends State<UploadMultiImgs> {
  List<XFile?> selectedImages = [null, null, null];

  /// upload max 3 images
  Future<void> _uploadMultiImages() async {
    final pickedImages = await ImagePicker().pickMultiImage(limit: 3);

    for (int i = 0; i < 3; i++) {
      selectedImages[i] = i < pickedImages.length ? pickedImages[i] : null;
    }

    setState(() {});
  }

  /// remove single image
  void _removeImage(int index) {
    setState(() {
      selectedImages[index] = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade900,

      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),

            // -----------------------------------------------------
            // IMAGES GRID — MODERN UI 3 SLOTS
            // -----------------------------------------------------
            SizedBox(
              height: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  final img = selectedImages[index];

                  return Stack(
                    children: [
                      // image box
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.35),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.20),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: img == null
                            ? Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 36,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  child: Image.file(
                                    File(img.path),
                                    key: ValueKey(img.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),

                      // remove icon
                      if (img != null)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.65),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 50),

            // -----------------------------------------------------
            // UPLOAD BTN — PREMIUM STYLE
            // -----------------------------------------------------
            GestureDetector(
              onTap: _uploadMultiImages,
              child: Container(
                width: 200,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.35),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Upload Images",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

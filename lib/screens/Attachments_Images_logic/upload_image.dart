import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  XFile? selectedImage;

  /// pick image from gallery
  Future<void> _uploadImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => selectedImage = img);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f8),

      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200),

            // ----------------------------------------------------
            // IMAGE BOX WITH REMOVE BUTTON
            // ----------------------------------------------------
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade400, width: 1.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: selectedImage == null
                      ? Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.grey.shade500,
                            size: 60,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.file(
                            File(selectedImage!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),

                // remove image button
                if (selectedImage != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedImage = null);
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 30),

            // ----------------------------------------------------
            // MAIN UPLOAD BUTTON (modern style)
            // ----------------------------------------------------
            GestureDetector(
              onTap: _uploadImage,
              child: Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xff0b8b59),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    selectedImage == null ? "Upload Image" : "Change Image",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // small hint
            Text(
              "Supported formats: PNG, JPG",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

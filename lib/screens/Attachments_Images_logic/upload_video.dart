import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  XFile? selectedVideo;
  VideoPlayerController? _controller;

  /// pick and load video
  Future<void> _uploadVideo() async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (picked != null) {
      // dispose previous video
      _controller?.dispose();

      _controller = VideoPlayerController.file(File(picked.path));
      await _controller!.initialize();
      _controller!.setLooping(true);
      _controller!.play();

      setState(() {
        selectedVideo = picked;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a1a1d),

      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),

            // -------------------------------------------------------
            // VIDEO PLAYER CONTAINER  (FULL FIT / COVER)
            // -------------------------------------------------------
            Container(
              width: 310,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: (_controller != null && _controller!.value.isInitialized)
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          // ---------- FULL FIT VIDEO ----------
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final videoWidth = _controller!.value.size.width;
                              final videoHeight =
                                  _controller!.value.size.height;

                              final containerWidth = constraints.maxWidth;
                              final containerHeight = constraints.maxHeight;

                              // aspect ratios
                              double videoAspect = videoWidth / videoHeight;
                              double containerAspect =
                                  containerWidth / containerHeight;

                              // scale factor to ensure full cover
                              double scale = containerAspect > videoAspect
                                  ? containerAspect / videoAspect
                                  : videoAspect / containerAspect;

                              return FittedBox(
                                fit: BoxFit.cover,
                                child: Transform.scale(
                                  scale: scale,
                                  child: SizedBox(
                                    width: videoWidth,
                                    height: videoHeight,
                                    child: VideoPlayer(_controller!),
                                  ),
                                ),
                              );
                            },
                          ),

                          // play/pause overlay button
                          GestureDetector(
                            onTap: () {
                              if (_controller!.value.isPlaying) {
                                _controller!.pause();
                              } else {
                                _controller!.play();
                              }
                              setState(() {});
                            },
                            child: AnimatedOpacity(
                              opacity: _controller!.value.isPlaying ? 0 : 1,
                              duration: const Duration(milliseconds: 200),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(12),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    // --------- Placeholder before picking video ---------
                    : Center(
                        child: Icon(
                          Icons.video_collection_outlined,
                          color: Colors.white.withOpacity(0.6),
                          size: 60,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 40),

            // -------------------------------------------------------
            // UPLOAD BUTTON
            // -------------------------------------------------------
            GestureDetector(
              onTap: _uploadVideo,
              child: Container(
                width: 200,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Upload Video",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

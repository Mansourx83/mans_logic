import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({super.key});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile>
    with SingleTickerProviderStateMixin {
  String? _fileName;
  String? _filePath;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc', 'jpg'],
    );

    if (file != null && file.files.single.name.isNotEmpty) {
      setState(() {
        _fileName = file.files.single.name;
        _filePath = file.files.single.path;
      });
      _animationController.forward(from: 0);
    }
  }

  void _deleteFile() {
    setState(() {
      _fileName = null;
      _filePath = null;
    });
    _animationController.reverse();
  }

  IconData _getFileIcon() {
    if (_fileName == null) return CupertinoIcons.doc;
    if (_fileName!.endsWith('.pdf')) return CupertinoIcons.doc_fill;
    if (_fileName!.endsWith('.jpg') || _fileName!.endsWith('.jpeg')) {
      return CupertinoIcons.photo_fill;
    }
    return CupertinoIcons.doc_text_fill;
  }

  Color _getFileColor() {
    if (_fileName == null) return Colors.grey.shade400;
    if (_fileName!.endsWith('.pdf')) return Colors.red.shade400;
    if (_fileName!.endsWith('.jpg') || _fileName!.endsWith('.jpeg')) {
      return Colors.blue.shade400;
    }
    return Colors.indigo.shade400;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Upload Files',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Upload Card
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Icon and File Info
                      Row(
                        children: [
                          // File Icon
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: _getFileColor().withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getFileIcon(),
                              color: _getFileColor(),
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // File Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _fileName ?? "No file uploaded yet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: _fileName != null
                                        ? Colors.black87
                                        : Colors.grey.shade600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "pdf, docx, doc, jpg",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Action Menu
                          Material(
                            color: Colors.transparent,
                            child: PopupMenuButton(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  CupertinoIcons.ellipsis_vertical,
                                  color: Colors.grey.shade700,
                                  size: 20,
                                ),
                              ),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    onTap: _pickFile,
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.arrow_up_doc,
                                          color: Colors.blue.shade600,
                                          size: 22,
                                        ),
                                        const SizedBox(width: 12),
                                        const Text(
                                          "Upload",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_fileName != null) ...[
                                    PopupMenuItem(
                                      onTap: _pickFile,
                                      child: Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.refresh,
                                            color: Colors.orange.shade600,
                                            size: 22,
                                          ),
                                          const SizedBox(width: 12),
                                          const Text(
                                            "Change",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: _deleteFile,
                                      child: Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.delete_solid,
                                            color: Colors.red.shade600,
                                            size: 22,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            "Delete",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ];
                              },
                            ),
                          ),
                        ],
                      ),

                      // Upload Button (if no file)
                      if (_fileName == null) ...[
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: _pickFile,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade600.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.cloud_upload,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Choose file to upload",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // PDF Preview
              if (_filePath != null && _filePath!.endsWith('pdf')) ...[
                const SizedBox(height: 32),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 500),
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SfPdfViewer.file(File(_filePath!)),
                    ),
                  ),
                ),
              ],

              // Image Preview
              if (_filePath != null &&
                  (_filePath!.endsWith('jpg') ||
                      _filePath!.endsWith('jpeg'))) ...[
                const SizedBox(height: 32),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 500),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(File(_filePath!), fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  const ImageViewerScreen({super.key, required this.imageUrl});

  Future<void> _downloadImage(BuildContext context, String url) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final response = await http.get(Uri.parse(url));
      final documentDirectory = await getExternalStorageDirectory();
      final file = File(
          '${documentDirectory!.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg');
      file.writeAsBytesSync(response.bodyBytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image downloaded to ${file.path}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Viewer'),
        backgroundColor: const Color(0xff17181f),
      ),
      body: Center(
        child: InstaImageViewer(
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.download, color: Colors.white),
                  onPressed: () => _downloadImage(context, imageUrl),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

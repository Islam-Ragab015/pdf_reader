import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfView extends StatelessWidget {
  final String url;
  final bool isAsset;

  const PdfView({super.key, required this.url, this.isAsset = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        backgroundColor: Colors.indigo,
      ),
      body: isAsset
          ? const PDF().fromAsset(
              url,
              errorWidget: (dynamic error) => Center(
                child: Text('Failed to load PDF: $error',
                    style: const TextStyle(color: Colors.red)),
              ),
            )
          : const PDF().cachedFromUrl(
              url,
              placeholder: (progress) => Center(
                child: Text('Loading... $progress %',
                    style: const TextStyle(fontSize: 20)),
              ),
              errorWidget: (dynamic error) => Center(
                child: Text('Failed to load PDF: $error',
                    style: const TextStyle(color: Colors.red)),
              ),
            ),
    );
  }
}

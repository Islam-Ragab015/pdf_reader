import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> recentFiles = [];

  Future<void> openLocalFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      recentFiles.insert(0, result.files.single.path!);
      if (recentFiles.length > 5) {
        recentFiles.removeLast();
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfView(
            url: result.files.single.path!,
            isAsset: false,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Reader'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 8,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Implement settings functionality if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final TextEditingController urlController =
                    TextEditingController();
                await showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 16,
                    backgroundColor: Colors.blueGrey[50],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Enter PDF URL',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: urlController,
                            decoration: InputDecoration(
                              hintText: 'Enter PDF URL',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Colors.blue[50],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  final url = urlController.text.trim();
                                  if (url.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PdfView(
                                          url: url,
                                          isAsset: false,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Open'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.link, size: 20),
              label: const Text(
                'Open PDF from URL',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purpleAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: Colors.purple.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PdfView(
                    url: 'assets/sample.pdf',
                    isAsset: true,
                  ),
                ),
              ),
              icon: const Icon(Icons.folder, size: 20),
              label: const Text(
                'Open PDF from Assets',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.greenAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: Colors.green.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (recentFiles.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No recent files found')),
                  );
                } else {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ListView.builder(
                        itemCount: recentFiles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(recentFiles[index]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfView(
                                    url: recentFiles[index],
                                    isAsset: false,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
              icon: const Icon(Icons.history, size: 20),
              label: const Text(
                'Open Recent Files',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: Colors.purple.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfView extends StatelessWidget {
  final String url;
  final bool isAsset;

  const PdfView({super.key, required this.url, this.isAsset = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        backgroundColor: Colors.deepPurpleAccent,
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

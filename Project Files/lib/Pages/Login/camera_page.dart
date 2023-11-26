import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  XFile? _capturedImage;
  static const backgroundColor = Color.fromRGBO(31, 29, 54, 1);

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    _initializeControllerFuture = _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _captureAndDisplayPhoto() async {
    try {
      await _initializeControllerFuture;

      final image = await _cameraController.takePicture();

      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  void _resetCapture() {
    setState(() {
      _capturedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Selfie'),
        backgroundColor: backgroundColor,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: _capturedImage != null
                            ? Transform(
                                alignment: Alignment.center,
                                transform:
                                    Matrix4.rotationY(180 * 3.1415927 / 180),
                                child: Image.file(
                                  File(_capturedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CameraPreview(_cameraController),
                      ),
                    ],
                  ),
                ),
                if (_capturedImage != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement save logic here
                        },
                        child: const Text('Save'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _resetCapture,
                        child: const Text('Back'),
                      ),
                    ],
                  ),
                if (_capturedImage == null)
                  ElevatedButton.icon(
                    onPressed: _captureAndDisplayPhoto,
                    icon: const Icon(Icons.camera),
                    label: const Text('Take Photo'),
                  ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      backgroundColor: backgroundColor,
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:faceapp/Database/local_helper.dart';
import 'package:faceapp/Database/firestore_helper.dart';

class CameraPage extends StatefulWidget {
  final Function()? refreshProfile;
  const CameraPage({Key? key, this.refreshProfile}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  File? _capturedImage;
  final picker = ImagePicker();
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
        _capturedImage = File(image.path);
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

  Future<void> _openGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _capturedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveAndNavigateToProfile() async {
    if (_capturedImage != null) {
      await LocalHelper.saveProfilePicture(_capturedImage!.path);

      String? userId = await LocalHelper.getUserId();

      if (userId != null) {
        await FirestoreHelper().uploadProfilePicture(userId, _capturedImage!);
      }

      widget.refreshProfile?.call();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Selfie'),
        backgroundColor: backgroundColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: _capturedImage != null
                ? Image.file(
                    _capturedImage!,
                    fit: BoxFit.cover,
                  )
                : FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CameraPreview(_cameraController);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
          if (_capturedImage != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _saveAndNavigateToProfile();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _captureAndDisplayPhoto,
                  icon: const Icon(Icons.camera),
                  label: const Text('Take Photo'),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _openGallery,
                  icon: const Icon(Icons.photo),
                  label: const Text('Open Gallery'),
                ),
              ],
            ),
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }
}

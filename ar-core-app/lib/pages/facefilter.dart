import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class FaceFilter extends StatefulWidget {
  const FaceFilter({Key? key}) : super(key: key);

  @override
  State<FaceFilter> createState() => _FaceFilterState();
}

class _FaceFilterState extends State<FaceFilter> {
  late ArCoreFaceController arCoreFaceController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Face Filter'),
          backgroundColor: Colors.black,
        ),
        body: ArCoreFaceView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableAugmentedFaces: true, // Placing object on face detection
        ),
      ),
    );
  }

  _onArCoreViewCreated(ArCoreFaceController faceController) {
    arCoreFaceController = faceController;

    // load Mesh
    loadMesh();
  }

  loadMesh() async {
    final ByteData textureBytes =
        await rootBundle.load("assets/fox_face_mesh_texture.png");
    arCoreFaceController.loadMesh(
      textureBytes: textureBytes.buffer.asUint8List(),
      skin3DModelFilename: "fox_face.sfb",
    );
  }

  @override
  void dispose() {
    super.dispose();
    arCoreFaceController.dispose();
  }
}

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class FlatSurface3DImage extends StatefulWidget {
  const FlatSurface3DImage({Key? key}) : super(key: key);

  @override
  State<FlatSurface3DImage> createState() => _FlatSurface3DImageState();
}

class _FlatSurface3DImageState extends State<FlatSurface3DImage> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flat Surface 3D Image'),
          backgroundColor: Colors.black,
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true, // Placing object on tap
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = _controlOnPlaneTap;
  }

  void _controlOnPlaneTap(List<ArCoreHitTestResult> hitsResults) {
    final hit = hitsResults.first;

    //Adding the 3D characters
    _addCharacter(hit);
  }

  Future _addCharacter(ArCoreHitTestResult hit) async {
    // Adding a character image
    final bytes =
        (await rootBundle.load("assets/pikachu.png")).buffer.asUint8List();

    final characterPos = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 250, height: 250),
      position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
      rotation: hit.pose.rotation + vector.Vector4(0.0, 0.0, 0.0, 0.0),
    );
    arCoreController.addArCoreNodeWithAnchor(characterPos);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

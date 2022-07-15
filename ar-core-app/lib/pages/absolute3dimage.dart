import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Absolute3DImage extends StatefulWidget {
  const Absolute3DImage({Key? key}) : super(key: key);

  @override
  _Absolute3DImageState createState() => _Absolute3DImageState();
}

class _Absolute3DImageState extends State<Absolute3DImage> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Absolute 3D Image'),
          backgroundColor: Colors.black,
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  // Creating AR Core view
  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onPlaneTap = controlOnPlaneTap;
  }

  void controlOnPlaneTap(List<ArCoreHitTestResult> results) {
    final hit = results.first;
    addQuotedImage(hit);
  }

  Future addQuotedImage(ArCoreHitTestResult hitTestResult) async {
    final bytes =
        (await rootBundle.load("assets/stevejobs.jpg")).buffer.asUint8List();

    final imageQuote = ArCoreNode(
      image: ArCoreImage(bytes: bytes, width: 600, height: 600),
      position: hitTestResult.pose.translation + vector.Vector3(0, 0, 0),
      rotation: hitTestResult.pose.rotation + vector.Vector4(0, 0, 0, 0),
    );
    arCoreController.addArCoreNodeWithAnchor(imageQuote);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

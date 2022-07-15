import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:vector_math/vector_math_64.dart' as vector;

class AnchorObject extends StatefulWidget {
  const AnchorObject({Key? key}) : super(key: key);

  @override
  _AnchorObjectState createState() => _AnchorObjectState();
}

class _AnchorObjectState extends State<AnchorObject> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Anchored Object onTap'),
          backgroundColor: Colors.black,
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
      ),
    );
  }

  // Creating AR Core view
  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text("onNodeTap on $name"),
      ),
    );
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addSphere(hit);
  }

  Future _addSphere(ArCoreHitTestResult hit) async {
    // Adding moon object
    final moonMaterial = ArCoreMaterial(color: Colors.grey);
    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );
    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0.2, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    // Adding Earth image over sphere
    final ByteData textureBytes = await rootBundle.load("assets/earth.jpg");

    final earthMaterial = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.1,
    );
    final earth = ArCoreNode(
      shape: earthShape,
      children: [moon],
      position: hit.pose.translation + vector.Vector3(0, 1.0, 0),
      rotation: hit.pose.rotation,
    );

    // Adding the node to AR Core controller
    arCoreController.addArCoreNodeWithAnchor(earth);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

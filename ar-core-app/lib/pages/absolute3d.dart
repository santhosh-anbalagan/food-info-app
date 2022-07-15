import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Absolute3D extends StatefulWidget {
  const Absolute3D({Key? key}) : super(key: key);

  @override
  _Absolute3DState createState() => _Absolute3DState();
}

class _Absolute3DState extends State<Absolute3D> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Absolute 3D Object Rotated'),
          backgroundColor: Colors.black,
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    _addCube(arCoreController);
  }

  void _addCube(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.green,
      metallic: 1.0,
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, 0.5, -3.5),
      rotation: vector.Vector4(2, 2, 0, 2),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

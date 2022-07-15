import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';

class Sofa extends StatefulWidget {
  const Sofa({Key? key}) : super(key: key);

  @override
  _SofaState createState() => _SofaState();
}

class _SofaState extends State<Sofa> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sofa Model'),
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
    arCoreController.onNodeTap = (name) => removeObject(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void removeObject(String name) {
    print("Flutter: onNodeTap");
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: [
            Text("Remove " + name),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                arCoreController.removeNode(nodeName: name);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
  // void onTapHandler(String name) {
  //   print("Flutter: onNodeTap");
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: Text("onNodeTap on $name"),
  //     ),
  //   );
  // }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addObject(hit);
  }

  _addObject(ArCoreHitTestResult plane) {
    final objectNode = ArCoreReferenceNode(
      name: "artic_fox.sfb",
      object3DFileName: "artic_fox.sfb", // Sample for now
      position: plane.pose.translation,
      rotation: plane.pose.rotation,
    );
    arCoreController.addArCoreNodeWithAnchor(objectNode);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

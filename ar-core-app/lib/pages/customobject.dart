import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';

class CustomObject extends StatefulWidget {
  const CustomObject({Key? key}) : super(key: key);

  @override
  _CustomObjectState createState() => _CustomObjectState();
}

class _CustomObjectState extends State<CustomObject> {
  late ArCoreController arCoreController;
  late String objectSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Objects wtih Shadow'),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ListObjectSelection(onTap: (value) {
                objectSelected = value;
              }),
            )
          ],
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

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addObject(hit);
  }

  _addObject(ArCoreHitTestResult plane) {
    if (objectSelected != null) {
      final objectNode = ArCoreReferenceNode(
        name: objectSelected,
        object3DFileName: objectSelected,
        position: plane.pose.translation,
        rotation: plane.pose.rotation,
      );
      arCoreController.addArCoreNodeWithAnchor(objectNode);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text("Select an Image"),
        ),
      );
    }
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

// UI
class ListObjectSelection extends StatefulWidget {
  final Function onTap;

  ListObjectSelection({required this.onTap});
  @override
  State<ListObjectSelection> createState() => _ListObjectSelectionState();
}

class _ListObjectSelectionState extends State<ListObjectSelection> {
  List<String> gifs = [
    'assets/TocoToucan.gif',
    'assets/AndroidRobot.gif',
    'assets/ArcticFox.gif',
  ];

  List<String> objectFileName = [
    "toucan.sfb",
    "andy.sfb",
    "artic_fox.sfb",
  ];

  late String selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
          itemCount: gifs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = gifs[index];
                  widget.onTap(objectFileName[index]);
                });
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Container(
                  color:
                      selected == gifs[index] ? Colors.red : Colors.transparent,
                  padding: selected == gifs[index] ? EdgeInsets.all(8.0) : null,
                  child: Image.asset(gifs[index]),
                ),
              ),
            );
          }),
    );
  }
}

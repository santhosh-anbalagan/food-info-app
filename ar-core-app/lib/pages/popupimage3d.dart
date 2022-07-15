import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PopUp3DImage extends StatefulWidget {
  const PopUp3DImage({Key? key}) : super(key: key);

  @override
  State<PopUp3DImage> createState() => _PopUp3DImageState();
}

class _PopUp3DImageState extends State<PopUp3DImage> {
  late ArCoreController arCoreController;
  Map<int, ArCoreAugmentedImage> augmentedImageMap = Map();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pop-up 3D Object on Detecting Image'),
          backgroundColor: Colors.black,
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          type: ArCoreViewType.AUGMENTEDIMAGES,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onTrackingImage = _controlOnTrackingImage;

    // Load single image
    loadSingleImage();
  }

  void _controlOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImageMap.containsKey(augmentedImage.index)) {
      augmentedImageMap[augmentedImage.index] = augmentedImage;

      // Add Sphere object
      addSphere(augmentedImage);
    }
  }

  Future addSphere(ArCoreAugmentedImage arCoreAugmentedImage) async {
    final ByteData textureBytes = await rootBundle.load("assets/earth.jpg");

    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: arCoreAugmentedImage.extentX / 2,
    );
    final node = ArCoreNode(
      shape: sphere,
    );
    arCoreController.addArCoreNodeToAugmentedImage(
        node, arCoreAugmentedImage.index);
  }

  loadSingleImage() async {
    final ByteData bytes =
        await rootBundle.load("assets/earth_augmented_image.jpg");
    arCoreController.loadSingleAugmentedImage(
        bytes: bytes.buffer.asUint8List());
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

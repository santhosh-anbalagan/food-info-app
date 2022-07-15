import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' as vector;

class EditableObject extends StatefulWidget {
  const EditableObject({Key? key}) : super(key: key);

  @override
  State<EditableObject> createState() => _EditableObjectState();
}

class _EditableObjectState extends State<EditableObject> {
  late ArCoreController arCoreController;
  late ArCoreNode sphereNode;

  double metallic = 0.0;
  double roughness = 0.4;
  double reflectance = 0.5;
  Color color = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Editable 3D Object'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            SphereControl(
              initialRoughnessValue: roughness,
              initialReflectanceValue: reflectance,
              initialMetallicValue: metallic,
              initialColor: color,
              onColorChange: onColorChange,
              onMetallicChange: onMetallicChange,
              onRoughnessChange: onRoughnessChange,
              onReflectanceChange: onReflectanceChange,
            ),
            Expanded(
              child: ArCoreView(
                onArCoreViewCreated: _onArCoreViewCreated,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addSphere(arCoreController);
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.pink,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    sphereNode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );

    // Adding the node to AR Kit controller
    controller.addArCoreNode(sphereNode);
  }

  onColorChange(Color newColor) {
    if (newColor != this.color) {
      this.color = newColor;
      updateMaterials();
    }
  }

  onMetallicChange(double newMetallic) {
    if (newMetallic != this.metallic) {
      this.metallic = newMetallic;
      updateMaterials();
    }
  }

  onRoughnessChange(double newRoughness) {
    if (newRoughness != this.roughness) {
      this.roughness = newRoughness;
      updateMaterials();
    }
  }

  onReflectanceChange(double newReflectance) {
    if (newReflectance != this.reflectance) {
      this.reflectance = newReflectance;
      updateMaterials();
    }
  }

  updateMaterials() {
    debugPrint("updateMaterials");
    if (sphereNode == null) {
      return;
    }
    debugPrint("updateMaterials sphere node not null");
    final material = ArCoreMaterial(
      color: color,
      metallic: metallic,
      roughness: roughness,
      reflectance: reflectance,
    );
    sphereNode.shape.materials.value = [material];
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

class SphereControl extends StatefulWidget {
  final double initialRoughnessValue;
  final double initialReflectanceValue;
  final double initialMetallicValue;
  final Color initialColor;
  final ValueChanged<Color> onColorChange;
  final ValueChanged<double> onMetallicChange;
  final ValueChanged<double> onRoughnessChange;
  final ValueChanged<double> onReflectanceChange;

  const SphereControl({
    Key? key,
    required this.initialRoughnessValue,
    required this.initialReflectanceValue,
    required this.initialMetallicValue,
    required this.initialColor,
    required this.onColorChange,
    required this.onMetallicChange,
    required this.onRoughnessChange,
    required this.onReflectanceChange,
  }) : super(key: key);

  @override
  State<SphereControl> createState() => _SphereControlState();
}

class _SphereControlState extends State<SphereControl> {
  late double metallicValue;
  late double roughnessValue;
  late double reflectanceValue;
  late Color color;

  @override
  void initState() {
    roughnessValue = widget.initialRoughnessValue;
    reflectanceValue = widget.initialReflectanceValue;
    metallicValue = widget.initialMetallicValue;
    color = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  final newColor = Colors.accents[Random().nextInt(14)];
                  widget.onColorChange(newColor);
                  setState(
                    () {
                      color = newColor;
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: Text("Random Color"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 20.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Metallic"),
              Checkbox(
                value: metallicValue == 1.0,
                onChanged: (value) {
                  metallicValue = value! ? 1.0 : 0.0;
                  widget.onMetallicChange(metallicValue);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text("Roughness"),
              Expanded(
                child: Slider(
                  value: roughnessValue,
                  divisions: 10,
                  onChangeEnd: (value) {
                    roughnessValue = value;
                    widget.onRoughnessChange(roughnessValue);
                  },
                  onChanged: (double value) {
                    setState(() {
                      roughnessValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Reflectance"),
              Expanded(
                child: Slider(
                  value: reflectanceValue,
                  divisions: 10,
                  onChangeEnd: (value) {
                    reflectanceValue = value;
                    widget.onReflectanceChange(reflectanceValue);
                  },
                  onChanged: (double value) {
                    setState(() {
                      reflectanceValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

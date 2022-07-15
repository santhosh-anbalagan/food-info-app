import 'package:flutter/material.dart';

import 'absolute3dimage.dart';
import 'customobject.dart';
import 'editableobject.dart';
import 'facefilter.dart';
import 'geometricshapes.dart';
import 'absolute3d.dart';
import 'matrix3d.dart';
import 'popupimage3d.dart';
import 'anchorobject.dart';
import 'autoplanedetect.dart';
import 'flatsurface3d.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              // Random page for now
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GeometricShapes(),
                ),
              ),
              child: const Text(
                'Geometric Shapes',
              ),
            ),

            // Not possible for now

            // ElevatedButton(
            //   // Random page for now
            //   onPressed: () {},
            //   child: const Text(
            //     'Static 3D Image',
            //   ),
            // ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Absolute3DImage(),
                ),
              ),
              child: const Text(
                'Absolute Position of 3D Image',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Absolute3D(),
                ),
              ),
              child: const Text(
                'Absolute Position of 3D Object',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AutoDetectPlane(),
                ),
              ),
              child: const Text(
                'Flat Surface Positioning of 3D Object',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FlatSurface3DImage(),
                ),
              ),
              child: const Text(
                'Place the 3D Image Based On User Input',
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text(
            //     'Movable Object (Animation) On The Plain Surface',
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text(
            //     'Scan QR & Pop Up AR On Top Of QR Code',
            //   ),
            // ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PopUp3DImage(),
                ),
              ),
              child: const Text(
                'Pop Up AR On Top Of Image',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FaceFilter(),
                ),
              ),
              child: const Text(
                'Use Face Filter',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditableObject(),
                ),
              ),
              child: const Text(
                'Edit-able Object at Runtime',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnchorObject(),
                ),
              ),
              child: const Text(
                'Anchor Object on Tap',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Matrix3D(),
                ),
              ),
              child: const Text(
                'Add 3D Matrix on Tap',
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomObject(),
                ),
              ),
              child: const Text(
                'Add Custom Objects on Tap',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

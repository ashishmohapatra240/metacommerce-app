import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class View3d extends StatelessWidget {
  static const String routeName = '/View3d';
  const View3d({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View your Model in 3d")),
      body: ModelViewer(
        src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        alt: "A 3D model of an astronaut",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}

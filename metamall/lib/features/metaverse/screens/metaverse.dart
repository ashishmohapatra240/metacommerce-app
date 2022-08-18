import 'package:flutter/material.dart';
import 'package:metamall/constants/global_variables.dart';

class Metaverse extends StatelessWidget {
  const Metaverse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) =>
                    GlobalVariables.secondGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Are you',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Ready',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Center(
                child: Image.asset(
                  'assets/images/Metaverse_Illustration.png',
                  height: 256,
                ),
              ),
              Text(
                'Instructions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'A cordial welcome to the Antique Fantasy World. Perceive the experience of viewing objects from a 3D perspective. Live through the Virtual Try-Ons, and make the journey superior while collecting Metacoins and accompanying others in your virtual  shopping.',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'System Requirements',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'The minimum requirements differ depending on if you’re running Decentraland via a web browser, or if you’re running a locally installed desktop client. The desktop client has considerably lower requirements, as it’s not limited by the browser.',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Minimum system requirements',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Processor: Intel® Core i3-9100 / AMD™ Athlon 3000G Video: NVIDIA® GeForce® GTX 670 / AMD™ Radeon RX 550 / Intel® UHD Graphics 630 RAM: 4GB',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 48,
              ),
              SizedBox(
                height: 52,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 1, 122, 228),
                        Color.fromARGB(255, 0, 206, 206),
                      ],
                      stops: [0.25, 0.75],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: ElevatedButton(
                    onPressed: (() {}),
                    child: Text(
                      'Enter the Metaverse',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

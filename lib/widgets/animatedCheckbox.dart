import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimatedCheckBox extends StatefulWidget {
  const AnimatedCheckBox({Key? key}) : super(key: key);

  @override
  _AnimatedCheckBoxState createState() => _AnimatedCheckBoxState();
}

class _AnimatedCheckBoxState extends State<AnimatedCheckBox> {
  Artboard? riveArtboard;
  SMIBool? isDance;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/animated_checkmark.riv').then(
      (data) async {
        try {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          var controller =
              StateMachineController.fromArtboard(artboard, 'State Machine 1');
          if (controller != null) {
            artboard.addController(controller);
            isDance = controller.findSMI('isChecked');
          }
          setState(() => riveArtboard = artboard);
        } catch (e) {
          print(e);
        }
      },
    );
  }

  void toggleDance(bool newValue) {
    setState(() => isDance!.value = newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: riveArtboard == null
          ? const SizedBox(width: 72)
          : Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => isDance!.value = !isDance!.value);
                    },
                    child: Container(
                      width: 72,
                      child: Rive(
                        artboard: riveArtboard!,
                      ),
                    ),
                  ),
                ),
                Text('Check!!'),
                Switch(
                  value: isDance!.value,
                  onChanged: (value) => toggleDance(value),
                ),
                const SizedBox(height: 12),
              ],
            ),
    );
  }
}

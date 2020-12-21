import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taluxi/core/constants/colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final double elevation;
  final VoidCallback onTap;
  const CustomElevatedButton(
      {Key key,
      this.elevation,
      this.child,
      this.width,
      this.height,
      this.onTap})
      : super(key: key);

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  double buttonElevation;
  bool buttonIsDown = false;

  @override
  void initState() {
    super.initState();
    buttonElevation = widget.elevation;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.width,
        height: widget.height + widget.elevation,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: const [Color(0xFFE0A500), Color(0xFFDF7E00)]),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(17)),
              ),
              bottom: 0,
            ),
            AnimatedPositioned(
              child: Container(
                width: widget.width,
                height: widget.height,
                child: Center(child: widget.child),
                decoration: BoxDecoration(
                  gradient: mainLinearGradient,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              bottom: buttonElevation,
              duration: Duration(milliseconds: 350),
              onEnd: () {
                if (buttonIsDown) widget.onTap();
                setState(() {
                  buttonElevation = widget.elevation;
                  buttonIsDown = false;
                });
              },
            )
          ],
        ),
      ),
      // onTap: widget.onTap,
      onTapDown: (_) => setState(() {
        buttonElevation = 0;
        buttonIsDown = true;
        // widget.onTap();
      }),
    );
  }
}

// class WaveButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final double size;
//   final Widget child;
//   final int waveCount;
//   final double distanceBetweenWaves;
//   final double waveBlurRaduis;
//   const WaveButton({
//     Key key,
//     this.size,
//     this.onTap,
//     this.waveBlurRaduis = 18,
//     this.child,
//     this.waveCount = 2,
//     this.distanceBetweenWaves = 40,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Stack(
//         alignment: Alignment.center,
//         children: waves(),
//       ),
//       onTap: onTap,
//     );
//   }

//   List<CircularWave> waves() {
//     var waveList = <CircularWave>[];
//     // We need to manualy add the last wave because he should contain a widget
//     // (the WaveButton child) so we need to substract wan 1 to the waveCount
//     var currentWaveIndex = waveCount - 1;
//     while (currentWaveIndex > 0) {
//       waveList.add(
//         CircularWave(
//           size: size + (distanceBetweenWaves * currentWaveIndex),
//           blurRadius: waveBlurRaduis - (currentWaveIndex * 2),
//         ),
//       );
//       currentWaveIndex--;
//     }
//     waveList.add(CircularWave(
//       size: size,
//       child: child,
//       blurRadius: waveBlurRaduis,
//     ));
//     return waveList;
//   }
// }

// class AnimatedWaveButton extends StatefulWidget {
//   final VoidCallback onTap;
//   final double size;
//   final Widget child;
//   final int waveCount;
//   final double distanceBetweenWaves;
//   final double minBlurRaduis;
//   final double maxBlurRaduis;
//   const AnimatedWaveButton({
//     Key key,
//     this.size,
//     this.onTap,
//     this.minBlurRaduis = 5,
//     this.maxBlurRaduis = 15,
//     this.child,
//     this.waveCount = 2,
//     this.distanceBetweenWaves = 40,
//   }) : super(key: key);

//   @override
//   _AnimatedWaveButtonState createState() => _AnimatedWaveButtonState();
// }

// class _AnimatedWaveButtonState extends State<AnimatedWaveButton>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation<double> waveBlurRaduisAnimation;
//   bool isReversedAnimation = false;

//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 3))
//           ..forward();
//     waveBlurRaduisAnimation =
//         Tween<double>(begin: widget.minBlurRaduis, end: widget.maxBlurRaduis)
//             .animate(controller);
//     controller.addListener(() {
//       setState(() {});
//       if (controller.status == AnimationStatus.completed) controller.reverse();
//       if (controller.status == AnimationStatus.dismissed)
//         Future.delayed(Duration(seconds: 6), () => controller.forward());
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WaveButton(
//       child: widget.child,
//       onTap: widget.onTap,
//       size: widget.size,
//       waveCount: widget.waveCount,
//       distanceBetweenWaves: widget.distanceBetweenWaves,
//       waveBlurRaduis: waveBlurRaduisAnimation.value,
//     );
//   }
// }

// class CircularWave extends StatelessWidget {
//   final double blurRadius;
//   const CircularWave({
//     Key key,
//     this.child,
//     this.blurRadius,
//     @required this.size,
//   }) : super(key: key);

//   final Widget child;
//   final double size;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(child: child),
//       height: size,
//       width: size,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         boxShadow: [
//           CustomBoxShadow(
//             color: Colors.black54,
//             blurRadius: blurRadius,
//             blurStyle: BlurStyle.outer,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomBoxShadow extends BoxShadow {
//   final BlurStyle blurStyle;

//   const CustomBoxShadow({
//     Color color = const Color(0xFF000000),
//     Offset offset = Offset.zero,
//     double blurRadius = 0.0,
//     this.blurStyle = BlurStyle.normal,
//   }) : super(color: color, offset: offset, blurRadius: blurRadius);

//   @override
//   Paint toPaint() {
//     final Paint result = Paint()
//       ..color = color
//       ..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
//     assert(() {
//       if (debugDisableShadows) result.maskFilter = null;
//       return true;
//     }());
//     return result;
//   }
// }

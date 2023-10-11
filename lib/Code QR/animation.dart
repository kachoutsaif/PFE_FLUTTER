import 'package:flutter/material.dart';

class ScannerAnimation extends AnimatedWidget {
  const ScannerAnimation({
    super.key,
    required Animation<double> animation,
    this.scanningColor = Colors.blue,
    this.scanningHeightOffset = 0.4,
  }) : super(
          listenable: animation,
        );

  final Color? scanningColor;
  final double scanningHeightOffset;

  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 330.0;
    return Center(
      child: SizedBox(
        height: 100,
        width: scanArea,
        child: LayoutBuilder(
          builder: (context, constrains) {
            const scanningGradientHeight = 50.0;
            final animation = listenable as Animation<double>;
            final value = animation.value;
            final scorePosition =
                (value * constrains.maxHeight * 2) - (constrains.maxHeight);

            final color = scanningColor ?? Colors.blue;

            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: scanningGradientHeight,
                    width: scanArea,
                    transform: Matrix4.translationValues(0, scorePosition, 0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [
                          0.0,
                          0.2,
                          10.9,
                          10.95,
                          1,
                        ],
                        colors: [
                          color.withOpacity(0.05),
                          color.withOpacity(0.1),
                          color.withOpacity(0.4),
                          color,
                          color,
                        ],
                      ),
                    ),
                    //  child: Image(image: AssetImage(Assets.iconsScanRectangle),width: scanArea,),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
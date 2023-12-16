import 'package:flutter/material.dart';
import 'package:reflection_effect/src/config_reflection.dart';

/// Widget that shows a reflection of its child
///
/// The [child] is the widget that will be reflected
/// The [settingReflection] is the setting of the reflection
///
/// Example:
/// ```dart
/// Reflection(
///  settingReflection: SettingReflection(
///     skewX: 0.2,
///     scaleY: 0.5,
///     opacity: 0.9,
///     reflectionLength: 0.4,
///     positionX: 0.2,
///     expandRight: 10,
///     below: -32,
///   child: const Text('Hello World ')
/// ),
///
class Reflection extends StatefulWidget {
  const Reflection({super.key, required this.child, this.settingReflection});

  final Widget child;
  final SettingReflection? settingReflection;

  @override
  State<Reflection> createState() => _ReflectWidgetState();
}

class _ReflectWidgetState extends State<Reflection>
    with WidgetsBindingObserver {
  OverlayPortalController controller = OverlayPortalController();
  Offset childPosition = Offset.zero;
  Size childSize = Size.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //Set position and show when widget is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox childRenderBox = context.findRenderObject() as RenderBox;
      childPosition = childRenderBox.localToGlobal(Offset.zero);
      childSize = childRenderBox.size;
      controller.show();
    });
  }

  //For reload position when size change
  @override
  void didChangeMetrics() async {
    super.didChangeMetrics();
    //Set position went size change
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      RenderBox childRenderBox = context.findRenderObject() as RenderBox;
      childPosition = childRenderBox.localToGlobal(Offset.zero);
      childSize = childRenderBox.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.settingReflection);
    SettingReflection sR = widget.settingReflection ?? SettingReflection();

    final double positionX = sR.positionX;
    final double reflectionLength = sR.reflectionLength;
    final double skewX = sR.skewX;
    final double scaleY = sR.scaleY;
    final double expandRight = sR.expandRight;
    final double opacity = sR.opacity;
    final double below = sR.below;

    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (BuildContext context) {
        return Positioned(
          top: childPosition.dy + childSize.height + below,
          left: childPosition.dx + positionX,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const <Color>[
                  Colors.black,
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(0, 0, 0, 0)
                ],
                stops: [0.0, reflectionLength, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Opacity(
              opacity: opacity,
              child: Transform(
                transform: Matrix4.skewX(skewX),
                child: Transform(
                  transform: Transform.scale(
                    scaleY: scaleY,
                  ).transform,
                  child: Transform(
                    filterQuality: FilterQuality.low,
                    transform: Matrix4.identity()..scale(1.0, -1.0),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(right: expandRight),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

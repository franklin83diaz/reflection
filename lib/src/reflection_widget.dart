import 'package:flutter/material.dart';
import 'package:reflection_effect/src/config_reflection.dart';

/// Widget that shows a reflection of its child
///
/// The [child] is the widget that will be reflected
/// The [reflectionOpacity] is the opacity of the reflection
/// The [negativeSpace] is the negative space between the child and the reflection
///
///
class Reflection extends StatefulWidget {
  const Reflection({
    super.key,
    required this.child,
  });

  final Widget child;

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
    SettingReflection settingReflection = SettingReflection();

    final double positionX = settingReflection.defaultReflection.positionX;
    final double reflectionLength =
        settingReflection.defaultReflection.reflectionLength;
    final double skewX = settingReflection.defaultReflection.skewX;
    final double scaleY = settingReflection.defaultReflection.scaleY;
    final double expandRight = settingReflection.defaultReflection.expandRight;
    final double opacity = settingReflection.defaultReflection.opacity;
    final double below = settingReflection.defaultReflection.below;

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

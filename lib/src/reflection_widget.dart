import 'package:flutter/material.dart';

/// Widget that shows a reflection of its child
///
/// The [child] is the widget that will be reflected
/// The [reflectionOpacity] is the opacity of the reflection
/// The [negativeSpace] is the negative space between the child and the reflection
///
///
class Reflection extends StatefulWidget {
  const Reflection(
      {super.key,
      required this.child,
      this.reflectionOpacity = 0.5,
      this.negativeSpace = 0});

  final Widget child;
  final double reflectionOpacity;
  final double negativeSpace;

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
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (BuildContext context) {
        return Positioned(
          top: childPosition.dy + childSize.height - widget.negativeSpace,
          left: childPosition.dx,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black, Color.fromARGB(0, 0, 0, 0)],
                stops: [0.0, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode
                .dstIn, // Usa el destino (contenido del ShaderMask) y descarta el origen (widget hijo)
            child: Opacity(
              opacity: widget.reflectionOpacity,
              child: Transform(
                filterQuality: FilterQuality.low,
                transform: Matrix4.identity()..scale(1.0, -1.0),
                alignment: Alignment.center,
                child: widget.child,
              ),
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

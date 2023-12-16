///Create CustomConfigReflection to custom reflection
///The [skewX] is the skew of the reflection 0.0 to 1.0
///The [scaleY] is the size of reflection widget 0.0 to 2.0
///The [opacity] is the opacity of the reflection 0.0 to 1.0
///The [reflectionLength] is the length of the reflection 0.0 to 1.0
///
class CustomSettingReflection {
  final double skewX;
  final double scaleY;
  final double opacity;
  final double reflectionLength;
  final double positionX;
  final double expandRight;
  final double below;

  CustomSettingReflection({
    this.skewX = 0.3,
    this.scaleY = 0.8,
    this.opacity = 0.5,
    this.reflectionLength = 0.4,
    this.positionX = 0.0,
    this.expandRight = 0.0,
    this.below = 0.0,
  });
}

class SettingReflection {
  final CustomSettingReflection defaultReflection = CustomSettingReflection(
    skewX: 0.3,
    scaleY: 0.5,
    opacity: 0.9,
    reflectionLength: 0.4,
    positionX: -2,
    expandRight: 6,
    below: -30,
  );
}

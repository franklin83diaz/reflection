///Create CustomConfigReflection to custom reflection
///The [skewX] is the skew of the reflection 0.0 to 1.0
///The [scaleY] is the size of reflection widget 0.0 to 2.0
///The [opacity] is the opacity of the reflection 0.0 to 1.0
///The [reflectionLength] is the length of the reflection 0.0 to 1.0
///
class SettingReflection {
  double skewX;
  double scaleY;
  double opacity;
  double reflectionLength;
  double positionX;
  double expandRight;
  double below;

  SettingReflection({
    this.skewX = 0.0,
    this.scaleY = 0.90,
    this.opacity = 1.0,
    this.reflectionLength = 8.0,
    this.positionX = 0.0,
    this.expandRight = 0.0,
    this.below = 1.0,
  });
}

enum SettingReflectionEnum {
  text,
  image,
}

extension SettingReflectionEnumExtensionon on SettingReflectionEnum {
  //get
  SettingReflection get setting {
    switch (this) {
      case SettingReflectionEnum.text:
        return SettingReflection(
          skewX: 0.2,
          scaleY: 0.5,
          opacity: 0.9,
          reflectionLength: 0.4,
          positionX: 0.2,
          expandRight: 10,
          below: 10,
        );
      case SettingReflectionEnum.image:
        return SettingReflection(
          skewX: 0.2,
          scaleY: 0.5,
          opacity: 0.5,
          reflectionLength: 0.4,
          positionX: 0.2,
          expandRight: 10,
          below: 1,
        );

      default:
        return SettingReflection();
    }
  }
}

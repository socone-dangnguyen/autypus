import 'dart:math';
import 'dart:ui';

class GeometryUtils {
  static double degreeToRadian(double angle) {
    return angle * (pi / 180);
  }

  static Offset calculatePoint(
      Offset startPoint, double angleDegrees, double length) {
    double angleRadians = GeometryUtils.degreeToRadian(angleDegrees);

    double x = startPoint.dx + length * cos(angleRadians);
    double y = startPoint.dy + length * sin(angleRadians);

    return Offset(x, y);
  }
}

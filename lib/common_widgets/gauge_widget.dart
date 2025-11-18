import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:noise_guard_app/core/theme/app_colors.dart';

// Widget Customizado para o Medidor (Gauge)
// Movido para 'common_widgets' para reutilização.
class GaugeWidget extends StatelessWidget {
  final double value;
  final double maxValue;
  final double startAngle;
  final double sweepAngle;

  const GaugeWidget({
    super.key,
    required this.value,
    this.maxValue = 100,
    this.startAngle = 135, // Início (12h é 270, 9h é 180, 8h é ~135)
    this.sweepAngle = 270, // Total (de 8h a 4h)
  });

  @override
  Widget build(BuildContext context) {
    // Normaliza o valor para o ângulo
    final double percent = (value / maxValue).clamp(0.0, 1.0);
    final double valueAngle = sweepAngle * percent;

    return CustomPaint(
      painter: _GaugePainter(
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        valueAngle: valueAngle,
        backgroundColor: DashboardColors.gaugeBackground,
        valueColor: DashboardColors.lineRed,
      ),
      child: Container(),
    );
  }
}

// CustomPainter para desenhar o arco do medidor
class _GaugePainter extends CustomPainter {
  final double startAngle; // Em graus
  final double sweepAngle; // Em graus
  final double valueAngle; // Em graus
  final Color backgroundColor;
  final Color valueColor;

  _GaugePainter({
    required this.startAngle,
    required this.sweepAngle,
    required this.valueAngle,
    required this.backgroundColor,
    required this.valueColor,
  });

  // Converte graus para radianos
  double _degToRad(double deg) => deg * math.pi / 180.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 10;
    const strokeWidth = 15.0;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final startRad = _degToRad(startAngle);
    final sweepRad = _degToRad(sweepAngle);
    final valueRad = _degToRad(valueAngle);

    // Pincel para o fundo
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Pincel para o valor
    final valuePaint = Paint()
      ..color = valueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Desenha o arco de fundo
    canvas.drawArc(rect, startRad, sweepRad, false, backgroundPaint);

    // Desenha o arco do valor
    canvas.drawArc(rect, startRad, valueRad, false, valuePaint);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.valueAngle != valueAngle;
  }
}

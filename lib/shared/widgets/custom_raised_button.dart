import 'package:drtime_patients/utils/hex_color.dart';
import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    @required this.label,
    @required this.onTap,
    this.color,
    this.labelColor = Colors.white,
    this.onLoadingTap,
    this.onLoadingWidget,
    this.height,
    this.width,
    this.gradient,
    this.enabled = true,
    this.loading = false,
    this.shadows,
    this.labelWeight = FontWeight.w500,
    this.borderRadius = 8.0,
    this.labelSize = 16,
  });

  final VoidCallback onLoadingTap;
  final Widget onLoadingWidget;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final bool loading;
  final bool enabled;
  final String label;
  final Color labelColor;
  final Gradient gradient;
  final VoidCallback onTap;
  final List<Shadow> shadows;
  final FontWeight labelWeight;
  final double labelSize;

  Widget buildSpinner(BuildContext context) {
    final ThemeData data = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: data.copyWith(accentColor: Colors.white),
        child: Center(child: CircularProgressIndicator(strokeWidth: 3.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled
          ? loading
              ? onLoadingTap
              : onTap
          : null,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        width: width ?? MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: color ?? HexColor('05B0DA'),
          gradient: gradient,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        child: loading
            ? onLoadingWidget ?? buildSpinner(context)
            : Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: labelWeight,
                    fontSize: labelSize,
                    color: labelColor,
                    shadows: shadows != null ? shadows : null,
                  ),
                ),
              ), // height / 2
      ),
    );
  }
}

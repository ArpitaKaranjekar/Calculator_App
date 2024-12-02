import 'package:flutter/material.dart';

class ButtonContainer extends StatefulWidget {
  final bool darkMode;
  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;

  const ButtonContainer({
    super.key,
    required this.darkMode,
    required this.child,
    required this.borderRadius,
    required this.padding,
  });

  @override
  State<ButtonContainer> createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() => _isPressed = true);
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        decoration: BoxDecoration(
          color: widget.darkMode
              ? const Color(0xFF374352)
              : const Color(0xFFe6eeff),
          borderRadius: widget.borderRadius,
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    color: widget.darkMode ? Colors.black54 : Colors.white,
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 9,
                  ),
                  BoxShadow(
                    color: widget.darkMode
                        ? Colors.black54
                        : const Color(0xFFd6e0f0),
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 9,
                  ),
                ],
        ),
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

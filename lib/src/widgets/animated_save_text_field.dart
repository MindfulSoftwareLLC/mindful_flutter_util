import 'package:flutter/material.dart';

class AnimatedSaveTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String fieldName;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final Function(String, String) onSave;
  final String? isSavingField;

  const AnimatedSaveTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.fieldName,
    this.maxLines,
    this.validator,
    required this.onSave,
    required this.isSavingField,
  }) : super(key: key);

  @override
  _AnimatedSaveTextFieldState createState() => _AnimatedSaveTextFieldState();
}

class _AnimatedSaveTextFieldState extends State<AnimatedSaveTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSavingField == widget.fieldName) {
      _animationController.repeat();
    } else {
      _animationController.stop();
      _animationController.reset();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          TextFormField(
            controller: widget.controller,
            decoration: buildInputDecoration(widget.label),
            style: const TextStyle(color: Colors.black87),
            maxLines: widget.maxLines,
            validator: widget.validator,
            onChanged: (value) {
              if (widget.validator == null ||
                  widget.validator!(value) == null) {
                widget.onSave(widget.fieldName, value);
              }
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _animation.value,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.withOpacity(0.5)),
                  minHeight: 2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration(String label) {
    // Implement your input decoration here
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }
}

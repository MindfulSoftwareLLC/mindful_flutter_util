import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InternationalHeightField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const InternationalHeightField(
      {super.key, this.initialValue, this.onChanged});

  @override
  InternationalHeightFieldState createState() =>
      InternationalHeightFieldState();
}

class InternationalHeightFieldState extends State<InternationalHeightField> {
  bool _isCm = true;
  final TextEditingController _cmController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _parseInitialValue();
  }

  void _parseInitialValue() {
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      if (widget.initialValue!.contains('cm')) {
        _isCm = true;
        _cmController.text = widget.initialValue!.replaceAll('cm', '');
        _updateCm();
      } else if (widget.initialValue!.contains('"')) {
        _isCm = false;
        final parts = widget.initialValue!.split("'");
        _feetController.text = parts[0];
        _inchesController.text = parts[1].replaceAll('"', '');
        _updateFeetInches();
      } else {
        debugPrint(
            'International height with neither cm nor " : ${widget.initialValue}');
      }
    }
  }

  void _updateCm() {
    final feet = int.tryParse(_feetController.text) ?? 0;
    final inches = int.tryParse(_inchesController.text) ?? 0;
    final totalInches = (feet * 12) + inches;
    final cm = (totalInches * 2.54).round();
    _cmController.text = cm.toString();
    _notifyChange();
  }

  void _updateFeetInches() {
    final cm = int.tryParse(_cmController.text) ?? 0;
    final totalInches = (cm / 2.54).round();
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;
    _feetController.text = feet.toString();
    _inchesController.text = inches.toString();
    _notifyChange();
  }

  void _notifyChange() {
    if (widget.onChanged != null) {
      widget.onChanged!(_isCm
          ? '${_cmController.text}cm'
          : "${_feetController.text}'${_inchesController.text}\"");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment<bool>(value: true, label: Text('cm')),
            ButtonSegment<bool>(value: false, label: Text('feet')),
          ],
          selected: {_isCm},
          onSelectionChanged: (Set<bool> newSelection) {
            setState(() {
              _isCm = newSelection.first;
            });
          },
        ),
        const SizedBox(height: 8),
        if (_isCm)
          SizedBox(
            width: 50,
            child: TextFormField(
              controller: _cmController,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (_) => _updateFeetInches(),
            ),
          )
        else
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _feetController,
                  decoration: const InputDecoration(
                    labelText: 'Feet',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (_) => _updateCm(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: _inchesController,
                  decoration: const InputDecoration(
                    labelText: 'Inches',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (_) => _updateCm(),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InternationalWeightField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;

  const InternationalWeightField(
      {super.key, this.initialValue, this.onChanged});

  @override
  InternationalWeightFieldState createState() =>
      InternationalWeightFieldState();
}

class InternationalWeightFieldState extends State<InternationalWeightField> {
  bool _isKg = true;
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _parseInitialValue();
  }

  void _parseInitialValue() {
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      if (widget.initialValue!.contains('kg')) {
        _isKg = true;
        _weightController.text = widget.initialValue!.replaceAll('kg', '');
      } else if (widget.initialValue!.contains('lbs')) {
        _isKg = false;
        _weightController.text = widget.initialValue!.replaceAll('lbs', '');
      } else {
        debugPrint(
            'International height with neither cm nor " : ${widget.initialValue}');
      }
    }
  }

  void _convertWeight() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    if (_isKg) {
      _weightController.text = (weight * 2.20462).toStringAsFixed(1);
    } else {
      _weightController.text = (weight / 2.20462).toStringAsFixed(1);
    }
    _notifyChange();
  }

  void _notifyChange() {
    if (widget.onChanged != null) {
      widget.onChanged!('${_weightController.text}${_isKg ? 'kg' : 'lbs'}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment<bool>(value: true, label: Text('kg')),
            ButtonSegment<bool>(value: false, label: Text('lbs')),
          ],
          selected: {_isKg},
          onSelectionChanged: (Set<bool> newSelection) {
            setState(() {
              _isKg = newSelection.first;
              _convertWeight();
            });
          },
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: _weightController,
            decoration: InputDecoration(
              labelText: 'Weight (${_isKg ? 'kg' : 'lbs'})',
              border: const OutlineInputBorder(),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
            ],
            onChanged: (_) => _notifyChange(),
          ),
        ),
      ],
    );
  }
}

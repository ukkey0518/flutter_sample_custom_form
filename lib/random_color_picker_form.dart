import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorPickerForm extends FormField<Color> {
  RandomColorPickerForm({
    required List<Color> values,
    super.key,
    super.initialValue,
    bool? enabled,
    super.onSaved,
    super.validator,
    super.restorationId,
    ValueChanged<Color>? onChanged,
    AutovalidateMode? autovalidateMode,
  }) : super(
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          enabled: enabled ?? true,
          builder: (state) {
            void onChangedHandler(Color value) {
              state.didChange(value);
              onChanged?.call(value);
            }

            return RandomColorPicker(
              values: values,
              initialValue: initialValue,
              onChanged: onChangedHandler,
              errorText: state.errorText,
              enabled: enabled ?? true,
            );
          },
        );

  @override
  FormFieldState<Color> createState() => FormFieldState();
}

class RandomColorPicker extends StatefulWidget {
  const RandomColorPicker({
    required this.values,
    super.key,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.errorText,
  });

  final List<Color> values;
  final Color? initialValue;
  final ValueChanged<Color>? onChanged;
  final bool enabled;
  final String? errorText;

  @override
  State<RandomColorPicker> createState() => _RandomColorPickerState();
}

class _RandomColorPickerState extends State<RandomColorPicker> {
  late Color? _currentValue = widget.initialValue;

  void _setValue() {
    final newValue = getNewValue();
    setState(() => _currentValue = newValue);
    widget.onChanged?.call(newValue);
  }

  Color getNewValue() {
    final newValue = widget.values[Random().nextInt(widget.values.length)];
    return newValue == _currentValue ? getNewValue() : newValue;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        errorText: widget.errorText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
      ),
      child: InkWell(
        onTap: widget.enabled ? _setValue : null,
        child: Container(
          height: kMinInteractiveDimension,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _currentValue,
          ),
        ),
      ),
    );
  }
}

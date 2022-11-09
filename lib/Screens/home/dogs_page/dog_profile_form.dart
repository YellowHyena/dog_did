import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DogProfileEntry extends StatelessWidget {
  const DogProfileEntry({
    Key? key,
    required this.text,
    required this.initialValue,
    this.decoration,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
  }) : super(key: key);

  final String text;
  final String? initialValue;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$text: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.tertiary),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            initialValue: initialValue,
            style: const TextStyle(fontSize: 20),
            decoration: decoration ?? const InputDecoration(counterText: '', border: InputBorder.none),
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            maxLength: maxLength,
          ),
        ),
      ],
    );
  }
}

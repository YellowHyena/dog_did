import 'package:dog_did/global_widgets/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DogProfileEntry extends StatefulWidget {
  const DogProfileEntry({
    Key? key,
    required this.text,
    this.decoration,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.controller,
  }) : super(key: key);

  final String text;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextEditingController? controller;

  @override
  State<DogProfileEntry> createState() => _DogProfileEntryState();
}

class _DogProfileEntryState extends State<DogProfileEntry> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${widget.text}: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme().tertiary),
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            style: const TextStyle(fontSize: 20),
            decoration: widget.decoration ??
                const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  errorStyle: TextStyle(height: 0),
                ),
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            controller: widget.controller,
          ),
        ),
      ],
    );
  }
}

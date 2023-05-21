import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberTextField extends StatefulWidget {
  final String namaLabel;
  const RememberTextField(
    this.namaLabel, {
    super.key,
  });

  @override
  State<RememberTextField> createState() => _RememberTextFieldState();
}

class _RememberTextFieldState extends State<RememberTextField> {
  final TextEditingController controller = TextEditingController();
  SharedPreferences? prefs;

  void updateValue() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("textInput-${widget.namaLabel}", controller.text);
  }

  Future<void> initializeTextField() async {
    prefs ??= await SharedPreferences.getInstance();
    String value = prefs!.getString("textInput-${widget.namaLabel}") ?? "";
    setState(() {
      controller.text = value;
      controller.addListener(updateValue);
    });
  }

  @override
  void initState() {
    initializeTextField();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(50, 145, 140, 140),
        filled: true,
        border: const OutlineInputBorder(),
        hintText: widget.namaLabel,
      ),
    );
  }
}

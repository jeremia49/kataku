import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberTextField extends StatefulWidget {
  final String namaLabel;
  RememberTextField(
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
    prefs.setString("label-${widget.namaLabel}", controller.text);
  }

  Future<void> initializeTextField() async {
    prefs ??= await SharedPreferences.getInstance();
    String value = prefs!.getString("label-${widget.namaLabel}") ?? "";
    setState(() {
      controller.text = value;
      controller.addListener(updateValue);
    });
  }

  @override
  void initState() {
    super.initState();
    initializeTextField();
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
        fillColor: Color.fromARGB(50, 145, 140, 140),
        filled: true,
        border: OutlineInputBorder(),
        hintText: widget.namaLabel,
      ),
    );
  }
}

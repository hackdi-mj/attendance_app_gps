import 'package:flutter/material.dart';

class MyUI {
  Widget button({
    required void onTap(),
    required String title,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        child: Container(
          width: double.infinity,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget myText({
    required String title,
    required var value,
  }) {
    return Container(
        width: 100,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  '${value}'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              )
            ]));
  }

  Widget textField({
    TextEditingController? controller,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    String? hintText,
    IconData? prefixIcon,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onSaved: onSaved,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            labelStyle: TextStyle(
              fontSize: 18,
            ),
            prefixIcon: Container(
              width: 50,
              child: Icon(
                prefixIcon,
                color: Colors.green,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(width: 2.0, color: Colors.green),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(width: 2.0, color: Colors.red),
            )),
        validator: validator);
  }
}

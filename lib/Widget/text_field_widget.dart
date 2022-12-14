import 'dart:ui';

import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  const TextFieldWidget(
      {Key? key,
      required this.title,
      required this.controller,
      required this.obscureText,
      required this.hintText})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode focusNode;
  bool isinFocus = false;
  @override
  
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
    if (focusNode.hasFocus){
      setState(() {
        isinFocus = true;
      });
    }else{
      setState(() {
        isinFocus=false;
      });
    }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            isinFocus?
            BoxShadow(
              color: Colors.orange.withOpacity(0.15),
              blurRadius: 8,
              spreadRadius: 2,
            ) : BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              spreadRadius: 2,
            ) 
          ]),
          child: TextField(
            focusNode: FocusNode(),
            obscureText: widget.obscureText,
            controller: widget.controller   ,
            maxLines: 1,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
                hintText: widget.hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 1,
                  ),
                )),
          ),
        )
      ],
    );
  }
}

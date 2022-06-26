import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget {

  const EmptyPage({Key? key})
      : super(key: key);

  @override
  State<EmptyPage> createState() => _CustomEmptyPageState();
}

class _CustomEmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:WikiMagic/helpers/helpers.dart';
import 'package:provider/provider.dart';

class PerformDisplay extends StatefulWidget {
  final Function? toggle;

  const PerformDisplay({Key? key, this.toggle}) : super(key: key);

  @override
  State<PerformDisplay> createState() => _PerformDisplayState();
}

class _PerformDisplayState extends State<PerformDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onDoubleTap: () {
          if(widget.toggle != null) {
            widget.toggle!();
          }
        },
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${context.read<MySearchTerm>().searchterm}'),
                Text('${context.read<MySelection>().selection}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'DeviceSize.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitHourGlass(
          color: Colors.red[400],
          size: displayWidth(context) * 0.1,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'DeviceSize.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitWave(
          color: Colors.blue[700],
          size: displayWidth(context) * 0.1,
        ),
      ),
    );
  }
}

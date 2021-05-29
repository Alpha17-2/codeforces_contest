import 'package:codeforces_contest/apiservices/cfapi.dart';
import 'package:codeforces_contest/main.dart';
import 'package:codeforces_contest/models/codeforcescontest.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'helpers/DeviceSize.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  List<Result> ongoing;
  List<Result> upcoming;
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
    //  _navigateToHome();
    });
  }

  Future<bool> _mockCheckForSession() async {
    ongoing =  await codeforcesApiServices().fetchOngoingContestList();
    upcoming = await codeforcesApiServices().fetchUpcomingContestList();

    await Future.delayed(Duration(seconds: 3), () {

    });

    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => home(ongoingContestList: ongoing,upcomingContestList: upcoming,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfbf0fff0),
        constraints: BoxConstraints.expand(),
        height: displayHeight(context),
        width: displayWidth(context),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ],
          ),
        ),
      ),
    );
  }
}

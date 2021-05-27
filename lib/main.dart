import 'package:codeforces_contest/apiservices/cfapi.dart';
import 'package:codeforces_contest/helpers/DeviceSize.dart';
import 'package:codeforces_contest/helpers/loading.dart';
import 'package:codeforces_contest/models/codeforcescontest.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  _homeState createState() => _homeState();
}
class _homeState extends State<home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    Widget displayContest(List<Result> contest,int index){
      return ListTile(
        title: Text(
          contest[index].name,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: displayWidth(context)*0.035,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('Start : ${contest[index].phase}'),

      );
    }
    return Scaffold(
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        constraints: BoxConstraints.expand(),
        color: Color(0xfbfaebd7),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: displayWidth(context)*0.03,
                //left: displayWidth(context)*0.02,
                child: Image(image: AssetImage(
                  'images/cf.png',
                ),
                  height: displayHeight(context)*0.07,
                  width: displayWidth(context)*0.54,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: displayHeight(context)*0.11,
                  child: Container(
                height: displayHeight(context)*0.84,
                    width: displayWidth(context)*0.95,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 2.5),
                    ),
                    child: FutureBuilder<List<Result>>(
                      future: codeforcesApiServices().fetchOngoingContestList(),
                      builder: (context,snapshots){
                        if(!snapshots.hasData)
                          return Loading();
                        return ListView.builder(itemBuilder: (context,index){
                          return displayContest(snapshots.data,index);
                        },
                          itemCount: snapshots.data.length,
                        );
                      },
                    )
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


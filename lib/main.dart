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
        subtitle: Text('Start :'+contest[index].startTimeSeconds.toString() ),

      );
    }
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfbf6f1f4),
        title: Image(image: AssetImage(
          'images/cf.png',
        ),
          height: displayHeight(context)*0.07,
          width: displayWidth(context)*0.54,
          fit: BoxFit.fill,
        ),
        bottom: TabBar(
          tabs: [
            Text('Ongoing',style: TextStyle(
              color: Colors.black87,
              fontSize: displayWidth(context)*0.042,
            ),),
            Text('Upcoming',style: TextStyle(
              color: Colors.black87,
              fontSize: displayWidth(context)*0.042,
            ),),
          ],
          labelPadding: EdgeInsets.only(bottom: 13),
          indicatorColor: Colors.red,
        ),
      ),
      body: TabBarView(
        children: [
          // Ongoing contest
          Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 20,bottom: 15)
          ,child: FutureBuilder<List<Result>>(
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
            ),
          ),

          // Upcoming contests
          Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 20,bottom: 15)
            ,child: FutureBuilder<List<Result>>(
              future: codeforcesApiServices().fetchUpcomingContestList(),
              builder: (context,snapshots){
                if(!snapshots.hasData)
                  return Loading();
                return ListView.builder(itemBuilder: (context,index){
                  return displayContest(snapshots.data,index);
                },
                  itemCount: snapshots.data.length,
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}


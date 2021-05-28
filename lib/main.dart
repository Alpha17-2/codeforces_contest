import 'package:codeforces_contest/apiservices/cfapi.dart';
import 'package:codeforces_contest/helpers/DeviceSize.dart';
import 'package:codeforces_contest/helpers/loading.dart';
import 'package:codeforces_contest/models/codeforcescontest.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
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

    Event contestEvent (DateTime dateTime,String title){
      return Event(
        title: title,
        description: 'Coding contest',
        location: 'Codeforces',
        endDate: dateTime.add(Duration(minutes: 30)),
        startDate: dateTime,
      );
    }

    Widget displayContest(List<Result> contest,int index){

      var date = DateTime.fromMillisecondsSinceEpoch(contest[index].startTimeSeconds * 1000);
      String start = DateFormat.yMMMd()
          .add_jm()
          .format(DateTime.parse(date.toString()));
      Color color = Color(0xfbf0f8ff);
      return Container(
        height: displayHeight(context)*0.1,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Colors.black87,offset: Offset(-3,1),blurRadius: 2),
          ]
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: displayHeight(context)*0.02,
                  left: displayWidth(context)*0.03,
                  right: displayWidth(context)*0.35,
                  child: Text(
                contest[index].name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: displayWidth(context)*0.0375,
                      color: Colors.black,
                    ),
              )),
              Positioned(
                  bottom : displayHeight(context)*0.03,
                  left: displayWidth(context)*0.03,
                  right: displayWidth(context)*0.1,
                  child: Text(
                  start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: displayWidth(context)*0.0375,
                      color: Colors.black38,
                    ),
                  ))
            ],
          ),
        ),


      );

      return ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        tileColor: Colors.pink[100],
        isThreeLine: true,
        trailing: IconButton(
          icon: Icon(Icons.alarm_add),
          onPressed: (){
            Add2Calendar.addEvent2Cal(
              contestEvent(date, contest[index].name),
            );
          },
          color: Colors.green,
        ),
        title: Text(
          contest[index].name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: displayWidth(context)*0.042,
            color: Colors.black87,
        ),
            overflow: TextOverflow.ellipsis,),
        subtitle: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Start : $start',style: TextStyle(
                color: Colors.black87,
                fontSize: displayWidth(context)*0.036,
                fontWeight: FontWeight.w600,
              ),),
              Text('Duration : $start',style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: displayWidth(context)*0.036,
              ),)
            ],
          ),
        ),
      );
    }
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfbf6f1f4),
        leading: Image(image: AssetImage(
          'images/cf.png',
        ),
          fit: BoxFit.fitHeight,
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: displayWidth(context)*0.055,
              fontFamily: 'Goldman',
            ),
            children: [
             TextSpan(text: 'CODE',style: TextStyle(
               color: Colors.black,
             )),
              TextSpan(text: 'TIME',style: TextStyle(
                color: Colors.red,
              )),

            ]
          ),
        ),
        bottom: TabBar(
          tabs: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ongoing',style: TextStyle(
                  color: Colors.black87,
                  fontSize: displayWidth(context)*0.042,
                ),),
                SizedBox(width: 8,),
                Icon(Icons.play_circle_fill,color: Colors.green,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Upcoming',style: TextStyle(
                  color: Colors.black87,
                  fontSize: displayWidth(context)*0.042,
                ),),
                SizedBox(width: 8,),
                Icon(Icons.pending_actions,color: Colors.pink,),
              ],
            ),
          ],
          labelPadding: EdgeInsets.only(bottom: 13),
          indicatorColor: Colors.indigo,
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
                  return Padding(
                    padding: const EdgeInsets.only(bottom:18.0),
                    child: displayContest(snapshots.data,index),
                  );
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
                  return Padding(
                    padding: const EdgeInsets.only(bottom:18.0),
                    child: displayContest(snapshots.data,index),
                  );
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


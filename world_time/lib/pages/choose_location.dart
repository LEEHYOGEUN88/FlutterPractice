import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  int counter = 0;

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];

    await instance.getTime();
    // navigate to home screen
    Navigator.pop(context, {
      'location': instance.location, 'flag': instance.flag, 'time': instance.time, 'isDaytime': instance.isDaytime,
    });
  }

/*
  // asiync 와 await 를 쓰면 해당 딜레이가 끝난 이후에 다음 라인으로 넘어감
  void getDate() async {

    // simultae network request for a username
    // Delay!
    String username = await Future.delayed(Duration(seconds: 3), (){
      return 'yoshi';
    });

    String bio = await Future.delayed(Duration(seconds: 2), (){
      return 'vega, musicial & egg collector';
    });

    // await 로 기다려서 각 값들이 지정이 끝난 후에야 아래 print를 처리함! 베리굿!
    print('$username - $bio');
  }
*/
  @override
  void initState() {
    super.initState();

    //getDate();
    print('hey there!');

    //print('initState function ran');
  }

  @override
  Widget build(BuildContext context) {
    //print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        elevation: 0,
        ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (contex, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical : 1, horizontal : 4),
            child: Card(
              child: ListTile(
                onTap: (){
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(backgroundImage: AssetImage('assets/${locations[index].flag}'),),
              ),
            ),
          );
        },
      ), 
        
      
      /*RaisedButton(
        onPressed: (){
          setState(() {
            counter += 1;
          });
        },
        child: Text('counter is $counter'),
      ),
      */
    );
  }
}
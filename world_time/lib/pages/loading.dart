import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  // asiync 와 await 를 쓰면 해당 딜레이가 끝난 이후에 다음 라인으로 넘어감
  void getDate() async {

    Response response = await get('http://jsonplaceholder.typicode.com/todos/1');
    // response 오브젝트의 response.body는 json data형식으로 data를 가져오게됨
    // 우리가 쓸 수 있는 Map 형식으로 convert 해줘야함 using jsonDecode(json format);
    Map data = jsonDecode(response.body) ;
    //print(data);
    //print(data['title']);

  }
/*
  void getTime() async{
    
    //make the request
    Response response = await get('http://worldtimeapi.org/api/timezone/Asia/Seoul');
    Map data = jsonDecode(response.body);

    //print(data);
    
    //get properties from data
    String datetime = data['utc_datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    //print(datetime);
    //print(offset);

    //creat a datetime object
    DateTime now = DateTime.parse(datetime);
    now.add(Duration(hours: int.parse(offset)));
    print(now);

  }*/

  // async 가 선언된 함수를 쓰려면 그 함수를 쓰는 함수도 async를 선언해야함!
  void setupWorldTime() async{
    WorldTime instance = WorldTime(location: 'Seoul', flag: 'korea.png', url: 'Asia/Seoul');
    await instance.getTime();

    //화면을 로딩화면이 끝나고 홈화면으로 넘겨주는 동작. arguments에서 홈화면으로 넘겨주고 싶은 값들을 넣어준다
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location, 'flag': instance.flag, 'time': instance.time, 'isDaytime': instance.isDaytime,
    });

    setState(() {
      time = instance.time;
    });
  }

  @override
  void initState() {
    super.initState();

    //getDate();
    //getTime();
    setupWorldTime();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],

      body: Center(

        // 밋밋한 Loading 화면에서 로딩같은 효과를 주기위해 Spinkit Package를 추가해서 아래와 같이 넣어줌
        // SpinKit 뒤에 마음에드는 이름의 스피킷이름을 넣어주면 바꿔줄 수 있음(Flutter package Site에서 고를 수 있다!)
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 50.0,
        )        
      ),

      /*
        Padding(
          padding: EdgeInsets.all(50),
          //child: Text(time),
          child: Text('Loading'),          
        ),
      */
    );
  }
}
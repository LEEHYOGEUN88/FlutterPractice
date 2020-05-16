import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; // the time in location

  String flag; // url to an asset flag icon
  String url; // location url for api 

  bool isDaytime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  // Future : value set이 완료 될 때까지 기다리는...
  Future<void> getTime() async{

    try{
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //print(data);
      
      //get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //creat a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
    
      // set the time property
      //time = now.toString();
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      // 계산적으로 표현된 시간을 사용자가 익숙한 포멧으로 변경해주는 라이브러리인 'intl' Package를 설치해주고 아래와 같이 DateFormat을 변경해줌
      time = DateFormat.jm().format(now);
    }
    catch (e){
      print('caught error: $e');
      time = 'could not get time data';
    }



    
  }
}



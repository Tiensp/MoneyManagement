import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/ui/shared/app_colors.dart';

class AppDocker extends StatefulWidget {

  @override
  _AppDockerState createState() => _AppDockerState();
}

class _AppDockerState extends State<AppDocker> {
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex:_currentIndex,
      onTap: (value){
        _currentIndex=value;
        _currentIndex==0? Navigator.of(context).pushNamed("chart"): Navigator.of(context).pushNamed("reminder");
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.pie_chart,color: Colors.grey[800],),
            title: Text('Thống kê',style: TextStyle(color: Colors.black87, fontSize: 15.0))),
        BottomNavigationBarItem(icon: Icon(Icons.notifications,color: Colors.grey[800],),
            title: Text('Nhắc nhở',style: TextStyle(color: Colors.black87, fontSize: 15.5),)),
      ],
      backgroundColor: Colors.cyan[200],
    );
  }
}

import 'package:attendance_gps/views/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../model/model.dart';
import 'user.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key? key}) : super(key: key);
  static const routeName = '/attendance';

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final ModelService _modelService = ModelService();
  final MapsService _mapsService = MapsService();
  double distance = 0;
  @override
  void initState() {
    _mapsService.getLoc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_mapsService.dateTime == null) {
      _modelService.attendaceValue[0] = 'on loading...';
    } else {
      _modelService.attendaceValue[0] = _mapsService.dateTime;
    }
    _modelService.attendaceValue[2] =
        '${_mapsService.distance.toStringAsFixed(2)} KM';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendace App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    'Campus Location :',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3.0,
                    ),
                    itemCount: _modelService.campusLocation.length,
                    itemBuilder: (BuildContext ctx, i) {
                      return InkWell(
                        onTap: (() {
                          setState(() {
                            for (int index = 0;
                                index < _modelService.campusButton.length;
                                index++) {
                              _modelService.campusButton[index] = index == i;
                            }
                          });
                          if (_modelService.campusLocation[i] ==
                              'kebon jeruk') {
                            setState(() {
                              _mapsService.pinnedLocation = LatLng(
                                  _modelService.campusKbj[0],
                                  _modelService.campusKbj[1]);
                              print(_mapsService.pinnedLocation);
                              print(_mapsService.totalDistance);
                            });
                          } else {
                            setState(() {
                              _mapsService.pinnedLocation = LatLng(
                                  _modelService.campusHi[0],
                                  _modelService.campusHi[1]);
                              print(_mapsService.pinnedLocation);
                              print(_mapsService.totalDistance);
                            });
                          }
                        }),
                        child: Container(
                            decoration: BoxDecoration(
                              color: _modelService.campusButton[i]
                                  ? Colors.green.shade900
                                  : Colors.green.shade500,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                '${_modelService.campusLocation[i]}'
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      );
                    }),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Text(
                    'Subject :',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3.0,
                    ),
                    itemCount: _modelService.subject.length,
                    itemBuilder: (BuildContext ctx, i) {
                      return InkWell(
                        onTap: (() {
                          setState(() {
                            for (int index = 0;
                                index < _modelService.subjectButton.length;
                                index++) {
                              _modelService.subjectButton[index] = index == i;
                            }
                          });
                        }),
                        child: Container(
                            decoration: BoxDecoration(
                              color: _modelService.subjectButton[i]
                                  ? Colors.green.shade900
                                  : Colors.green.shade500,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                '${_modelService.subject[i]}'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      );
                    }),
              ],
            ),
          ),
          Card(
            elevation: 5,
            margin: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              width: double.infinity,
              decoration: (BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      children: [
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 9,
                              childAspectRatio: 1.6,
                            ),
                            itemCount: _modelService.attendaceInfo.length,
                            itemBuilder: (BuildContext ctx, i) {
                              return Container(
                                child: MyUI().myText(
                                    title: '${_modelService.attendaceInfo[i]}'
                                        .toUpperCase(),
                                    value: '${_modelService.attendaceValue[i]}'
                                        .toUpperCase()),
                              );
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: MyUI().button(
                      onTap: () {
                        if (_mapsService.distance >= 0.05) {
                          final snackBar = SnackBar(
                            content: Text(
                              'Your attendance has been rejected !',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red,
                            action: SnackBarAction(
                              label: 'Dismiss',
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.of(context).pushNamed(UserPage.routeName);
                        }
                      },
                      title: 'Take Attendance'.toUpperCase(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.all(30),
            child: Text(
              'Announcement : if your pin location is more than 50 meters from the campus, the system will reject your attendance ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black26,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            height: 200,
          )
        ]),
      ),
    );
  }
}

import 'package:attendance_gps/controller/controller.dart';
import 'package:attendance_gps/views/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import '../model/model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formAtt = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _nim = TextEditingController();
  LocationData? _currentPosition;
  String? _dateTime;
  Location location = Location();
  double distance = 0.0;
  LatLng pinnedLocation = LatLng(-6.174639, 106.954630);

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    LatLng(_currentPosition!.latitude!.toDouble(),
        _currentPosition!.longitude!.toDouble());
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
        LatLng(_currentPosition!.latitude!.toDouble(),
            _currentPosition!.longitude!.toDouble());

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
      });
    });
    double totalDistance = 0;
    totalDistance = ModelService().calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        pinnedLocation.latitude,
        pinnedLocation.longitude);

    setState(() {
      distance = totalDistance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attendace App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(UserPage.routeName);
                },
                icon: Icon(
                  Icons.history,
                ),
              )
            ],
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                    key: _formAtt,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: _textField(
                            controller: _name,
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            hintText: 'Name',
                            onSaved: (value) {
                              _nim.text == value;
                            },
                            validator: (val) =>
                                val!.isEmpty ? 'Input your name' : null,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: _textField(
                            controller: _nim,
                            prefixIcon: Icons.badge_outlined,
                            keyboardType: TextInputType.number,
                            hintText: 'NIM',
                            validator: (val) =>
                                val!.isEmpty ? 'Input your nim' : null,
                          ),
                        ),
                        Container(
                          child: _form(
                            value:
                                'Lat : ${pinnedLocation.latitude}, Lng : ${pinnedLocation.longitude}',
                            icon: Icons.push_pin_outlined,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: _form(
                            value: _currentPosition != null
                                ? 'Lat : ${_currentPosition!.latitude}, Lng : ${_currentPosition!.longitude}'
                                : 'Your Location',
                            icon: Icons.my_location_outlined,
                          ),
                        ),
                        Container(
                          child: _form(
                            value: _currentPosition != null
                                ? '${_dateTime}'
                                : 'Date/Time',
                            icon: Icons.date_range_outlined,
                          ),
                        ),
                      ],
                    )),
                Container(
                  child: Text(
                    'Announcement : if your pin location is more than 50 meters from the campus, the system will reject your attendance ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: _button(
                          onTap: () {
                            UserData().setName(_name.text);
                            print(_name.text);
                            UserData().setNim(_nim.text);
                            UserData().setDate(_nim.text);
                            UserData().setDistance(_nim.text);
                          },
                          icon: Icons.my_location_outlined,
                          title: 'Check',
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: _button(
                            onTap: () {
                              if (_formAtt.currentState!.validate()) {
                                final snackBar = SnackBar(
                                  content: Text(distance >= 50
                                      ? '${distance.toStringAsFixed(2)} Km. Your attendance has been rejected !'
                                      : '${distance.toStringAsFixed(2)} Km. Your attendance has been accepted !'),
                                  backgroundColor: Colors.black45,
                                  action: SnackBarAction(
                                    label: 'dismiss',
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            title: 'Attendace Now',
                            icon: Icons.face_outlined,
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _form({
    required String value,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            child: Icon(
              icon,
              color: Colors.green,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: 20,
                top: 10,
                bottom: 10,
              ),
              child: Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textField({
    TextEditingController? controller,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    String? hintText,
    IconData? prefixIcon,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onSaved: onSaved,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: hintText,
            errorStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            labelStyle: TextStyle(
              fontSize: 18,
            ),
            prefixIcon: Container(
              width: 50,
              child: Icon(
                prefixIcon,
                color: Colors.green,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(width: 2.0, color: Colors.green),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(width: 2.0, color: Colors.red),
            )),
        validator: validator);
  }

  Widget _button({
    required void onTap(),
    required String title,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        child: Container(
          width: double.infinity,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

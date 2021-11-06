import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imc/core/constants/app_strings.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({this.user, Key? key}) : super(key: key);

  final String?
      user; // Shall receive as parameter as User from google authentication.

  @override
  Widget build(BuildContext context) {
    return user == null ? _unloggedScreen() : _loggedScreen();
  }

  Widget _loggedScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.google),
          SizedBox(height: 16.0),
          Text('${AppStrings.connectedAs} ${user}'),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: Text(AppStrings.unconnect),
          )
        ],
      ),
    );
  }

  Widget _unloggedScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          Text(
            AppStrings.noAccountConnected,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Text(
            AppStrings.noAccountConnectedInfo,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () {},
            label: Text(AppStrings.connect),
            icon: Icon(FontAwesomeIcons.google),
          )
        ],
      ),
    );
  }
}

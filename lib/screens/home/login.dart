import 'package:elred_test/enums.dart';
import 'package:flutter/material.dart';

import '../../arguments.dart';
import '../../service/app_service.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static const String route = '/Login';
  const Login({Key? key}) : super(key: key);

  @override
  State createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Text('You are not currently signed in.'),
        ElevatedButton(
          onPressed: () => AppService.login().then((value) {
            if (value) {
              AppService.navigateTo(Home.route,
                  arguments:
                      HomeArguments(navigation: NAVIGATION.pushReplacement));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to login')));
            }
          }),
          child: const Text('SIGN IN'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      )),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/data/services/api.dart';

import 'app/app.dart';
import 'logic/bloc_observer.dart';

void main() async{
  DioHelper.initDio();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  BlocOverrides.runZoned(() {
      runApp(MyApp());
  },
    blocObserver: MyBlocObserver(),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_app/data/repos/camera_repo.dart';
import 'package:ocr_app/data/repos/gallery_repo.dart';
import 'package:ocr_app/mybloc_observer.dart';
import 'package:ocr_app/presentation/bloc/image_bloc.dart';
import 'package:ocr_app/presentation/pages/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc(CameraRepo(), GalleryRepo()),
      child: MaterialApp(home: HomeScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_details_hive_bloc/application/update_bloc/update_bloc.dart';
import 'package:sample_details_hive_bloc/presentation/home/home_screen.dart';
import 'application/home_bloc/home_bloc_bloc.dart';
import 'application/search_bloc/search_bloc.dart';
import 'domain/student_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBlocBloc>(
          create: (context) => HomeBlocBloc(),
        ),
                BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<UpdateBloc>(
          create: (context) => UpdateBloc(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: GoogleFonts.montserrat().fontFamily,
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.black,
              primarySwatch: Colors.teal),
          home: HomeScreen()),
    );
  }
}

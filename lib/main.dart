import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
import 'layout/news_app/news_layout.dart';
import 'shared/bloc_observer.dart';



void main()
{
  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();

          DioHelper.init();
          await CacheHelper.init();
          bool? isDark  = CacheHelper.getData('isDark');

          runApp( MyApp(isDark!));
          },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {

  final bool isDark ;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (BuildContext context) => NewsCubit()..getSports()..getScience()..getBusiness()),
        BlocProvider(create: (BuildContext context) => NewsCubit()..changeAppMode(fromShared: isDark,)),
      ],
        child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.amber,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.amber,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.amber,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.amber,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.amber,
                  elevation: 20.0,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                ),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.amber,
                scaffoldBackgroundColor: HexColor('3e403f'),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('3e403f'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor('3e403f'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.amber,

                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.amber,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('3e403f'),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

              ),
              themeMode: NewsCubit.get(context).isDark? ThemeMode.dark: ThemeMode.light ,
              home: NewsLayout(),
            );
          },
        ),
      );

  }
}

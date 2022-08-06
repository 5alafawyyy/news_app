import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    getBusiness();
    if(index == 1) getSports();
    if(index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country' : 'eg',
        'category' : 'business',
        'apiKey' : '53cedf44397e4d5f9e7db715c34b6582',
      }


    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];

      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
    {
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];
  void getScience()
  {
    emit(NewsGetBusinessLoadingState());

    if(science.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country' : 'eg',
          'category' : 'science',
          'apiKey' : '53cedf44397e4d5f9e7db715c34b6582',
        },

          ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      science = value.data['articles'];

      emit(NewsGetScienceSuccessState());
    }).catchError((error)
    {

      emit(NewsGetScienceErrorState(error.toString()));
    });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }


  }

  List<dynamic> sports = [];
  void getSports()
  {
    emit(NewsGetBusinessLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'country' : 'eg',
          'category' : 'sports',
          'apiKey' : '53cedf44397e4d5f9e7db715c34b6582',
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];


        emit(NewsGetSportsSuccessState());
      }).catchError((error)
      {

        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else
    {
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> search = [];

  void getSearch( value)
  {
    emit(NewsGetSearchLoadingState());

    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q' : '$value',
        'apiKey' : '53cedf44397e4d5f9e7db715c34b6582',
      },
    ).then((value)
    {
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null) 
    {
      isDark = fromShared;
    }
    else
    {
      isDark = !isDark;
    }
    CacheHelper.putData('isDark', isDark).then((value)
    {
      emit(ChangeAppModeState());
    });
    /*
    if(isDark == true) {
      print('Dark Mode');
    } else {
      print('Light Mode');
    }
    */

  }


}


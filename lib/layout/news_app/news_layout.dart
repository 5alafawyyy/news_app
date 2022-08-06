import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
    builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'News',
            ),
            actions:
            [
              IconButton(
              onPressed: ()
              {
                navigateTo(
                    context,
                  SearchScreen(),
                );
              },
                icon: Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: ()
                {
                  cubit.changeAppMode();
                },
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),

              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),

        );
    },
    );

  }
}

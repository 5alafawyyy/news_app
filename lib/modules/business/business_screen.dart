import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

import '../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state)
      {
        var list = NewsCubit.get(context).business;

        return articleBuilder(list, context);
      },

    );
  }
}
/*
Expanded(
                    child: Text(
                      'New feeds here, welcome to our page..',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black45,
                      ),
                    ),
                  ),

*/
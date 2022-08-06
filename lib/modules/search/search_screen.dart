import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(
            //title: Text(
              //'Search',
            //),
          ),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  readOnly: false,
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: ( value){
                    if(value.isEmpty){
                      return 'Search must not be Null!';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                  child: articleBuilder(
                    list,
                    context,
                    isSearch : true,
                  )),
            ],
          ),
        );
      },
    );
  }
}

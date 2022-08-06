
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/web_view/web_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: 190.0,
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget listDivider() => Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(

  condition: list.length > 0,

  builder: (context) =>  ListView.separated(

    physics: BouncingScrollPhysics(),

    itemBuilder: (context, index) => buildArticleItem(list[index], context),

    separatorBuilder: (context, index) => listDivider(),

    itemCount: list.length,

  ),

  fallback: (context) => isSearch? Container() : Center(child: CircularProgressIndicator()),

);


Widget defaultButton(
    {
      double width = double.infinity,
      Color background = Colors.blue,
      required Function() function,
      required String text,

    }) => Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
      ),
    ) ,),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  onTap,
  onChange,
  required validate,
  required String label,
  required IconData prefix,
  bool autofocus = false,
  bool showCursor = true,
  bool readOnly = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  validator: validate,
  onTap: onTap,
  autofocus: autofocus,
  onChanged:onChange,
  showCursor: showCursor,
  readOnly: readOnly,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
        prefix
    ),
    focusedBorder:OutlineInputBorder(
      borderSide: const BorderSide(
          color: Colors.blue,
          width: 2.0
      ),
      borderRadius: BorderRadius.circular(25.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(),
    ),

  ),


);

Widget defaultTextFormField
    ({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required validate,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),

      ),
    );


void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
);
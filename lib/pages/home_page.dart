import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super (key:key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override

  Widget build(BuildContext context)
  {
      return Scaffold(
        appBar:AppBar(
          actions: [
            IconButton(onPressed: (){
              nextScreen(context, const SearchPage());
            }, 
            icon: const Icon(
              Icons.search,
              ))
          ]
          elevation: 0,         
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "People", 
          style: TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
          )
          ),
      );
  }
}
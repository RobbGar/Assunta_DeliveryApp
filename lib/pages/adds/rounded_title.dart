import 'dart:ui';

import 'package:flutter/material.dart';
import 'clipper.dart';



class RoundedTitle extends StatelessWidget {
  final String title;

  RoundedTitle({this.title});

  @override
  Widget build(BuildContext context) {

    return ClipPath(
      clipper: MyClipper(),
      child: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 250,
                
              decoration: BoxDecoration(

                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.4)
                    ]
                ),
              ),
              
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              )
          ),
      ]
      ),
    );
  }
}


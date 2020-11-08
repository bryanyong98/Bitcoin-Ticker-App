
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'coin_data.dart';
import 'dart:io' show Platform ;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_font_icons/crypto_font_icon_data.dart';

class CoinCard extends StatelessWidget {

  IconData icon   ;
  String coinName ;
  String symbol   ;

  CoinCard({IconData icon, String coinName, String symbol});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 85,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFF4F3F7),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(

            width: 70,
            height: double.infinity,
            child: Icon(
              icon
            ),

          ),

          Flexible(
            flex: 4,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      coinName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      softWrap: true,
                    ),
                    Container(
                      height: 6,
                    ),
                    Text(
                      symbol,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            ),

        ],
      ),
    );
  }
}

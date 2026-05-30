import 'package:flutter/material.dart';

class RepositoryBase {
  bool isInit=false;

  @mustCallSuper
  Future init() async{
    isInit=true;
  }
}
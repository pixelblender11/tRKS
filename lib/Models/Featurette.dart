import 'dart:math';
import 'dart:typed_data';

class Featurette {
  Uint8List? image;
  String description="";
  String url="";
  int itemKey=-1;

  Featurette({
    this.image,
    this.description="",
    this.url="",
    this.itemKey=-1,
});

  factory Featurette.getDummy(){
    Featurette featured=Featurette();
    featured.url="google.com";
    return featured;
  }
}
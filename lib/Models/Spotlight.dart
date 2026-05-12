import 'dart:math';
import 'dart:typed_data';

class Spotlight {
  Uint8List? image;
  String title;
  String description;
  String url;
  String buttonText;
  bool leftImageAlign;
  int itemKey;

  Spotlight({
    this.image,
    this.title="",
    this.description="",
    this.url="",
    this.buttonText="",
    this.leftImageAlign=true,
    this.itemKey=-1,
  });

  factory Spotlight.getDummy(){
    Spotlight spotlight=Spotlight();
    spotlight.title="This is the title of a spotlight item";
    spotlight.description="The sun dipped low behind the hills, casting long shadows across the quiet street. A gentle breeze stirred the leaves, carrying with it the faint scent of rain. Somewhere in the distance, a door closed softly, and the world settled into a calm, expectant hush.";
    spotlight.url="google.com";
    spotlight.buttonText="Go now!";
    return spotlight;
  }
}
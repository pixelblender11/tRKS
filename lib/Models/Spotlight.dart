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
    spotlight.title="Here is some title text about pizza";
    spotlight.description="Pizza is kinda bomb. Like peporoni slices, with cheese!? On BREAD?! Seriously dude. Heeeeeell Yeah. Pizza is the best food invention known to man, dont you know? You can even mix and match toppings! Get a side of garlic knots and call it fat city. Amirite home skillet? I know im right, dont answer that.";
    spotlight.url="google.com";
    spotlight.buttonText="Go now!";
    return spotlight;
  }
}
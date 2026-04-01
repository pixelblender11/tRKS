import 'package:flutter/cupertino.dart';

class Footer extends StatelessWidget{
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      constraints: BoxConstraints(
        maxWidth: 600
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              Text("Terms"),
              Text("|"),
              Text("Conditions"),
              Text("|"),
              Text("Support"),
            ],
          ),
          Center(child: Text("Copyright © 2019 Kendra Sunderland All rights reserved.")),
          Center(child: Text("All models were at least eighteen (18) years of age when they were photographed.",textAlign: TextAlign.center,)),
          Center(child: Text("18 U.S.C. § 2257")),
        ],
      ),
    );
  }

}
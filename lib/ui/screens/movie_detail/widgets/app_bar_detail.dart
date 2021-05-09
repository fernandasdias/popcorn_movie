import 'package:flutter/material.dart';

import 'package:PopcornMovie/ui/theme/colors.dart';

class AppBarDetail extends PreferredSize {
  final String imagePath;
  final BuildContext context;

  AppBarDetail({
    required this.imagePath,
    required this.context,
  }) : super(
            preferredSize: Size.fromHeight(250),
            child: Container(
              height: 450,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      // TO-DO: Shadow
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(imagePath), fit: BoxFit.cover),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 24, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.chevron_left,
                            color: kPrimaryColorLightest,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 1.0),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Image.network(imagePath),
                      ),
                    ),
                  )
                ],
              ),
            ));
}

import 'package:flutter/material.dart';

String uri = 'http://192.168.60.106:3000';
// String uri = 'https://some-mobileapp.herokuapp.com';

class Keys {
  static final messangerKey = GlobalKey<ScaffoldMessengerState>();
}

class GlobalVariables {
  // COLORS


  static const primaryGradient = LinearGradient(colors: [
    Color.fromARGB(255, 236, 0, 140),
    Color.fromARGB(255, 252, 103, 103),
  ]);

  static const secondGradient = LinearGradient(colors: [
    Color.fromARGB(255, 1, 122, 228),
    Color.fromARGB(255, 0, 206, 206),
  ]);

  static const secondaryColor = Color.fromRGBO(236, 0, 140, 1);
  static const backgroundColor = Color(0xff090909);
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const Color cardBackgroundColor = Color(0xff1C1B1F);

  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

// STATIC IMAGES
  static const List<String> carouselImages = [
    'https://res.cloudinary.com/dvypwlby2/image/upload/v1659154826/znavuutlp2uhqsljr371.png',
    'https://res.cloudinary.com/dvypwlby2/image/upload/v1659154826/edwhieoqtvno8lvn4cay.png',
    'https://res.cloudinary.com/dvypwlby2/image/upload/v1659154825/v7ganpnuerrik7udji3f.png',
    'https://res.cloudinary.com/dvypwlby2/image/upload/v1659154826/znavuutlp2uhqsljr371.png',
    'https://res.cloudinary.com/dvypwlby2/image/upload/v1659154826/edwhieoqtvno8lvn4cay.png',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.png',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.png',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.png',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.png',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.png',
    },
  ];
}

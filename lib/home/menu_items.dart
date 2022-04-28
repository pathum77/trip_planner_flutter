import 'package:flutter/material.dart';
import 'package:trip_planner/home/menu_item.dart';

class MenuItems{
  static const List<MenuItem> itemsFirst = [
    itemProfile,
    // itemSettings,
    // itemShare,
  ];

  static const List<MenuItem> itemsSecond = [
    itemSignOut,
  ];

  static const itemProfile = MenuItem(
    text: 'Profile',
    icon: Icons.person_pin,
  );

  // static const itemSettings = MenuItem(
  //   text: 'Settins',
  //   icon: Icons.settings,
  // );

  // static const itemShare = MenuItem(
  //   text: 'Share',
  //   icon: Icons.share,
  // );

  static const itemSignOut = MenuItem(
    text: 'Sign out',
    icon: Icons.logout,
  );
}
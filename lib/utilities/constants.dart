import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kDefaultBackgroundColour = Color(0xff000738);
const kDefaultGoldenColour = Color(0xffffa51a);


const Icon kHomeIcon = Icon(
  Icons.home,
  size: 30,
  color: Colors.grey,
);

const Icon kHomeIconActive = Icon(
  Icons.home,
  size: 30,
  color: kDefaultGoldenColour,
);

const Icon kPersonIcon = Icon(
  Icons.person,
  size: 30,
  color: Colors.grey,
);

const Icon kPersonIconActive = Icon(
  Icons.person,
  size: 30,
  color: kDefaultGoldenColour,
);

const Icon kSettingsIcon = Icon(
  Icons.settings,
  size: 30,
  color: Colors.grey,
);

const Icon kSettingsIconActive = Icon(
  Icons.settings,
  size: 30,
  color: kDefaultGoldenColour,
);


const ksideBarDiv = Divider(
  color: kDefaultGoldenColour,
  thickness: 2,
);

const kSideBarTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.normal,
  color: kDefaultGoldenColour
);
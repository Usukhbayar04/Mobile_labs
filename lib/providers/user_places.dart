import '../models/place.dart';
import 'package:flutter/material.dart';

class Provider_Place extends ChangeNotifier{
// ignore: non_constant_identifier_names
final List<Place> userPlaces=[];

  addPlace(Place a){
    userPlaces.add(a);
    debugPrint('list size: ${userPlaces.length}');
    notifyListeners();
  }
  Provider_Place(){
  notifyListeners();
  }

}
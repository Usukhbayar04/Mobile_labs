import 'package:flutter/material.dart';
import '../models/place.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Center(
        child: ElevatedButton(onPressed:()=>{EasyLoading.showToast('Toast')} , child: Text(
          place.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    ));
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../providers/user_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImage(place.image),
            _buildDetails(context, place),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(File image) {
    return Image.file(
      image,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 250,
    );
  }

  Widget _buildDetails(BuildContext context, Place place) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10.0),
          _buildLocationRow(place),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => EasyLoading.showToast(place.title),
            child: const Text('Show Toast'),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => _deletePlace(context, place.id),
            child: const Text('Delete Place'),
          ),
        ],
      ),
    );
  }

  Row _buildLocationRow(Place place) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.amber,
        ),
        const SizedBox(width: 5.0),
        Text(
          'Lat: ${place.location.latitude}, Lon: ${place.location.longitude}',
          style: const TextStyle(color: Colors.amber),
        ),
      ],
    );
  }

  void _deletePlace(BuildContext context, String id) {
    Provider.of<Provider_Place>(context, listen: false).deletePlace(id);
    Navigator.of(context).pop();
  }
}

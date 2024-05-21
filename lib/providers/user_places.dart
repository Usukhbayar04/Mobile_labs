import 'dart:io';
import 'package:sqflite/sqflite.dart';
import '../models/place.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class Provider_Place extends ChangeNotifier {
  List<Place> userPlaces = [];

  Future<Database> _getDataBase() async {
    final database = await openDatabase(
      path.join(await getDatabasesPath(), 'use_places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id INTEGER PRIMARY KEY, title TEXT, image TEXT, lat REAL, lon REAL)',
        );
      },
      version: 1,
    );
    return database;
  }

  void loadPlaces() async {
    final db = await _getDataBase();
    final data = await db.query('places');
    final places = data
            .map((row) => Place(
                  id: row['id'] as String,
                  title: row['title'] as String,
                  image: File(row['image'] as String),
                  location: PlaceLocation(
                    latitude: row['lat'] as double,
                    longitude: row['lon'] as double,
                  ),
                ))
            .toList(),
        serPlaces = places;
    notifyListeners();
  }

  Future<void> addPlace(Place a) async {
    userPlaces.add(a);
    debugPrint('list size: ${userPlaces.length}');
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(a.image.path);
    print('PATH: $appDir/$fileName');
    final copiedImage = await a.image.copy('${appDir.path}/$fileName');

    final database = await openDatabase(
      path.join(await getDatabasesPath(), 'use_places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE places(id INTEGER PRIMARY KEY, title TEXT, image TEXT, lat REAL, lon REAL)',
        );
      },
      version: 1,
    );

    database.insert(
      'places',
      {
        'id': a.id,
        'title': a.title,
        'image': '${appDir.path}/$fileName',
        'lat': a.location.latitude,
        'lon': a.location.longitude,
      },
    );
    loadPlaces();
    notifyListeners();
  }

  Future<void> deletePlace(String id) async {
    final database = await _getDataBase();
    final result = await database.query(
      'places',
      columns: ['image'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      final imagePath = result.first['image'] as String;
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        await imageFile.delete();
      }
    }
    await database.delete(
      'places',
      where: 'id = ?',
      whereArgs: [id],
    );
    userPlaces.removeWhere((place) => place.id == id);
    notifyListeners();
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      isFavorite: json['isFavorite'] as bool? ?? false,
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      rating: json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
      count: (json['count'] as num?)?.toInt() ?? 1,
    );

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      rate: (json['rate'] as num?)?.toDouble(),
      count: (json['count'] as num?)?.toInt(),
    );

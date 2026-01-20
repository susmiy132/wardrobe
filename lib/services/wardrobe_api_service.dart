import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/clothing_model.dart';

class WardrobeApiService{
  // Get all clothes
  static Future<List<Clothing>> fetchClothes() async {
    final res = await http.get(Uri.parse("${ApiConfig.baseUrl}/all"));
    final List data = jsonDecode(res.body);
    return data.map((e) => Clothing.fromJson(e)).toList();
  }

  // Add clothing with image

  static Future<void> addClothing(
  File image,
  Map<String, String> data,
) async {
  final uri = Uri.parse("${ApiConfig.baseUrl}/add");

  final request = http.MultipartRequest('POST', uri);

  // Add text fields
  request.fields.addAll(data);

  // Add image file
  final multipartFile = await http.MultipartFile.fromPath(
    'image',
    image.path,
    contentType: http.MediaType('image', 'jpeg'), // IMPORTANT
  );

  request.files.add(multipartFile);

  // Send request
  final response = await request.send();

  if (response.statusCode != 200 && response.statusCode != 201) {
    throw Exception("Failed to upload clothing");
  }
}

  // static Future<void> addClothing(
  //   File image,
  //   Map<String, String> data,
  // ) async {
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse("${ApiConfig.baseUrl}/add"),
  //   );

  //   request.fields.addAll(data);
  //   request.files.add(
  //     await http.MultiPartFile.fromPath("image", image.path),
  //   );

  //   await request.send();
  // }


  // Occasion recommendation
  static Future<List<Clothing>> recommendByOccasion(String occasion) async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/recommend/occasion?occsion=$occasion"),
      );
      final List data = jsonDecode(res.body);
      return data.map((e) => Clothing.fromJson(e)).toList();
  }

  // Weather recommendation
  static Future<List<Clothing>> recommendByWeather(String city) async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/recommend/weather?city=$city"),
    );
    return (jsonDecode(res.body)['Clothes'] as List)
      .map((e) => Clothing.fromJson(e))
      .toList();
  }


  // AI recommendation
  static Future<List>aiRecommend(String city, String occasion) async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/recommend/ai?city=$city&occasion=$occasion"),
    );
    return jsonDecode(res.body)['outfits'];
  }

  static Future getAllClothes() async {}

  static Future getWeatherRecommendation() async {}

  static Future getAiRecommendation() async {}
}
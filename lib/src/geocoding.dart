part of google_places_for_flutter;

class Geocoding {
  String? apiKey;
  String? language;
  Geocoding({this.apiKey, language = 'en'});

  Future<dynamic> getGeolocation(String address,String apiHost,{MarkHttpHeader? headers}) async {
    String trimmedAddress = address.replaceAllMapped(' ', (m) => '+');
    final url =
        "$apiHost/geocode?address=$trimmedAddress&language=$language";
    final response = await http.get(Uri.parse(url),headers: headers?.call());
    final json = JSON.jsonDecode(response.body);
    if (json is Map<String,dynamic>) {
      return Geolocation.fromJSON(json);
    } else {
      var error = json["message"];
      if (error == "This API project is not authorized to use this API.")
        error +=
            " Make sure both the Geolocation and Geocoding APIs are activated on your Google Cloud Platform";
      throw Exception(error);
    }
  }
}
